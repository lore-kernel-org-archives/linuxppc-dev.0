Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id A68B2679E0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 15:08:55 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 6DF5F8780C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 22:08:42 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r689220842D-00-2
	for linuxppc-embedded@ozlabs.org; Wed, 09 Aug 2006 22:08:42 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 319798780B7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 22:08:42 -0700 (PDT)
Message-ID: <44DABF53.5020908@gmail.com>
Date: Thu, 10 Aug 2006 10:38:35 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: regarding pci  vga card output with powerpc
References: <44D7097C.7040907@gmail.com> <44DA6A72.7020502@varma-el.com>
In-Reply-To: <44DA6A72.7020502@varma-el.com>
Content-Type: multipart/alternative;
	boundary="------------020704090803020009030009"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020704090803020009030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrey Volkov wrote:
> urwithsudheer wrote:
>> Hello All,
>> I am working with a pci based vga card. I have connected the vga card 
>> next to the  pci slot of my target processor on the baseboard.
>> I have connected a monitor to the vga card.
>> When i boot linux from minicom, i could see all the kernel log 
>> messages on both the minicom and vga card monitor. But on the vga 
>> monitor, i could not see any messages after asking for login as below:
>> .
>> .
>>
>> Mounting filesystems
>> Running depmod
>> Setting up networking on loopback device:
>> Setting up networking on eth0:
>> eth0: PHY is Marvell 88E11x1 (1410cc2)
>> Adding static route for default gateway to 192.168.3.1:
>> Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
>> Starting inetd:
>>
>> login:
>>
>>
>> Though i am entering my login and passwd at the minicom, nothing 
>> comes on to the vga monitor. But i am able to write to vga monitor 
>> using the following commands from minicom:
>>
>> # echo "Hello" > /dev/tty1
>> # echo "Hi " > /dev/tty1
>> My requirement is to get on the vga monitor whatever i am typing on 
>> the minicom after logging into the linux like .
>> ls or pwd commands.
>>
>> Anyone pl help me.
>>
>> Thanks & Regards
>> Sudheer
>>
>
> See Documentation/kernel-parameters.txt.
>
> If be short, add:
>
>     console=/dev/ttySxx console=/dev/tty1
>
> (both) to a kernel parameters string.
>
I got upto login prompt on the vga monitor only after giving the above 
parameters in my u-boot bootargs.
u-boot=> set bootargs console=tty1 console=ttyS0,115200.


I have added in the serial driver  linux/drivers/serial/serial_core.c
   in the function  uart_write(struct tty_struct *tty, const unsigned 
char * buf, int count)
   The lines in the if directive.
  
if (c <= 0)
                        break;
                memcpy(circ->buf + circ->head, buf, c);
/* added to test vga */
#if 1
                memcpy(tempbuf, circ->buf + circ->head, c);
                  for(i=0;i<c;i++)
                  printk("%c", tempbuf[i]);
#endif

 circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
                buf += c;

Then as i expected, all the letters i enter in the minicom came twice on 
the minicom.

login:rroooott
Password: Password:
login  on `ttyS0'ogin  on `ttyS0'login[83]: root

 ~ # ~ # llss
 ~ # ~ # iiffccoonnffiigg

And whatever i enter on the minicom also gets print on the vga monitor  
but only once.
When i comment the if directive, On the vga monitor i could see only 
upto login prompt.

I don't know why the printk statement i added in the serial driver 
prints on the vga monitor.

As said by shkatikannan, i am going through the vga driver to copy to 
the frambuffer. But  yet couldn't get it exactly in the code where to copy.

Please tell me if i am in the wrong path.

Thanks & Regards
Sudheer





> -- 
> Regards
> Andrey
>
>


--------------020704090803020009030009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Andrey Volkov wrote:
<blockquote cite="mid44DA6A72.7020502@varma-el.com" type="cite">urwithsudheer
wrote:
  <br>
  <blockquote type="cite">Hello All,
    <br>
I am working with a pci based vga card. I have connected the vga card
next to the&nbsp; pci slot of my target processor on the baseboard.
    <br>
I have connected a monitor to the vga card.
    <br>
When i boot linux from minicom, i could see all the kernel log messages
on both the minicom and vga card monitor. But on the vga monitor, i
could not see any messages after asking for login as below:
    <br>
.
    <br>
.
    <br>
    <br>
Mounting filesystems
    <br>
Running depmod
    <br>
Setting up networking on loopback device:
    <br>
Setting up networking on eth0:
    <br>
eth0: PHY is Marvell 88E11x1 (1410cc2)
    <br>
Adding static route for default gateway to 192.168.3.1:
    <br>
Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
    <br>
Starting inetd:
    <br>
    <br>
login:
    <br>
    <br>
    <br>
Though i am entering my login and passwd at the minicom, nothing comes
on to the vga monitor. But i am able to write to vga monitor using the
following commands from minicom:
    <br>
    <br>
# echo "Hello" &gt; /dev/tty1
    <br>
# echo "Hi " &gt; /dev/tty1
    <br>
My requirement is to get on the vga monitor whatever i am typing on the
minicom after logging into the linux like .
    <br>
ls or pwd commands.
    <br>
    <br>
Anyone pl help me.
    <br>
    <br>
Thanks &amp; Regards
    <br>
Sudheer
    <br>
    <br>
  </blockquote>
  <br>
See Documentation/kernel-parameters.txt.
  <br>
  <br>
If be short, add:
  <br>
  <br>
&nbsp;&nbsp;&nbsp; console=/dev/ttySxx console=/dev/tty1
  <br>
  <br>
(both) to a kernel parameters string.
  <br>
  <br>
</blockquote>
I got upto login prompt on the vga monitor only after giving the above
parameters in my u-boot bootargs.<br>
u-boot=&gt; set bootargs console=tty1 console=ttyS0,115200.<br>
<br>
<br>
I have added in the serial driver&nbsp; linux/drivers/serial/serial_core.c<br>
&nbsp;&nbsp; in the function&nbsp; uart_write(struct tty_struct *tty, const unsigned
char * buf, int count)<br>
&nbsp;&nbsp; The lines in the if directive.<br>
&nbsp;&nbsp; <br>
if (c &lt;= 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(circ-&gt;buf + circ-&gt;head, buf, c);<br>
/* added to test vga */<br>
#if 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(tempbuf, circ-&gt;buf + circ-&gt;head, c);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(i=0;i&lt;c;i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("%c", tempbuf[i]);<br>
#endif<br>
<br>
&nbsp;circ-&gt;head = (circ-&gt;head + c) &amp; (UART_XMIT_SIZE - 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf += c;<br>
<br>
Then as i expected, all the letters i enter in the minicom came twice
on the minicom.<br>
<pre><font color="#000000">login:rroooott
</font><font color="#000000">Password: Password:
</font><font color="#000000">login  on `ttyS0'ogin  on `ttyS0'login[83]: root

</font><font color="#000000"> ~ # ~ # llss
</font><font color="#000000"> ~ # ~ # iiffccoonnffiigg</font></pre>
And whatever i enter on the minicom also gets print on the vga monitor&nbsp;
but only once.<br>
When i comment the if directive, On the vga monitor i could see only
upto login prompt.<br>
<br>
I don't know why the printk statement i added in the serial driver
prints on the vga monitor.<br>
<br>
As said by shkatikannan, i am going through the vga driver to copy to
the frambuffer. But&nbsp; yet couldn't get it exactly in the code where to
copy.<br>
<br>
Please tell me if i am in the wrong path.<br>
<br>
Thanks &amp; Regards<br>
Sudheer<br>
<br>
<br>
<br>
<br>
<br>
<blockquote cite="mid44DA6A72.7020502@varma-el.com" type="cite">--
  <br>
Regards
  <br>
Andrey
  <br>
  <br>
  <br>
</blockquote>
<br>
</body>
</html>

--------------020704090803020009030009--
