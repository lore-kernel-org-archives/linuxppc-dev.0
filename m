Date: Sat, 26 Jun 2004 19:52:43 -0400
From: Alan Cox <alan@redhat.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: [paulus@samba.org: Re: ans-lcd: multiple races]
Message-ID: <20040626235243.GA17491@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ysgrifennodd Paul Mackerras <paulus@samba.org>

>Alan Cox writes:
>
>> Seems the author of this driver never thought about races or errors
>> very much. I just noticed this trying to find the locking when looking
>> at misc_register races.
>
>That's a driver that I have never used or even looked at very closely.
>
>Could you post your patch to linuxppc-dev@lists.linuxppc.org?
>
>----


--- drivers/macintosh/ans-lcd.c~	2004-06-26 18:00:24.113683552 +0100
+++ drivers/macintosh/ans-lcd.c	2004-06-26 18:00:24.113683552 +0100
@@ -22,6 +22,7 @@
 static unsigned long anslcd_short_delay = 80;
 static unsigned long anslcd_long_delay = 3280;
 static volatile unsigned char* anslcd_ptr;
+static DECLARE_MUTEX(anslcd_lock);

 #undef DEBUG

@@ -61,6 +62,8 @@

 	if ( verify_area(VERIFY_READ, buf, count) )
 		return -EFAULT;
+
+	down(&anslcd_lock);
 	for ( i = *ppos; count > 0; ++i, ++p, --count )
 	{
 		char c;
@@ -68,6 +71,7 @@
 		anslcd_write_byte_data( c );
 	}
 	*ppos = i;
+	up(&anslcd_lock);
 	return p - buf;
 }

@@ -76,11 +80,14 @@
 				unsigned int cmd, unsigned long arg )
 {
 	char ch, *temp;
-
+	int ret = 0;
+
 #ifdef DEBUG
 	printk(KERN_DEBUG "LCD: ioctl(%d,%d)\n",cmd,arg);
 #endif

+	down(&anslcd_lock);
+
 	switch ( cmd )
 	{
 	case ANSLCD_CLEAR:
@@ -89,7 +96,7 @@
 		anslcd_write_byte_ctrl ( 0x06 );
 		anslcd_write_byte_ctrl ( 0x01 );
 		anslcd_write_byte_ctrl ( 0x02 );
-		return 0;
+		break;
 	case ANSLCD_SENDCTRL:
 		temp = (char *) arg;
 		__get_user(ch, temp);
@@ -97,20 +104,24 @@
 			anslcd_write_byte_ctrl ( ch );
 			__get_user(ch, temp);
 		}
-		return 0;
+		break;
 	case ANSLCD_SETSHORTDELAY:
 		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		anslcd_short_delay=arg;
-		return 0;
+			ret = -EACCES;
+		else
+			anslcd_short_delay=arg;
+		break;
 	case ANSLCD_SETLONGDELAY:
 		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		anslcd_long_delay=arg;
-		return 0;
+			ret = -EACCES;
+		else
+			anslcd_long_delay=arg;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+	up(&anslcd_lock);
+	return ret;
 }

 static int __pmac
@@ -150,9 +161,16 @@
 		return -ENODEV;

 	anslcd_ptr = (volatile unsigned char*)ioremap(ANSLCD_ADDR, 0x20);
-
+	if(anslcd_ptr == NULL)
+		return -ENOMEM;
+
+	down(&anslcd_lock);
+	/* Locked so that an opener cannot race the init writes to the
+	   chip after misc_register */
+
 	retval = misc_register(&anslcd_dev);
 	if(retval < 0){
+		up(&anslcd_lock);
 		printk(KERN_INFO "LCD: misc_register failed\n");
 		iounmap(anslcd_ptr);
 		return retval;
@@ -170,6 +188,7 @@
 	for(a=0;a<80;a++) {
 		anslcd_write_byte_data(anslcd_logo[a]);
 	}
+	up(&anslcd_lock);
 	return 0;
 }


--
  "The United States is putting together a Constitution now for Iraq.  Why
   don't we just give them ours?  It's served us well for 200 years, and we
   don't appear to be using it anymore, so what the hell?"
			-- Jay Leno


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
