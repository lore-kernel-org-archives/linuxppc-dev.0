Message-ID: <003f01c3b3de$da6b69d0$c314a8c0@cm>
From: "Sampath Kumar" <sampath@spartanlabs.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: unable to restore keyboard mode
Date: Wed, 26 Nov 2003 11:03:41 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,
I am trying to get the key press & release event from the keyboard. That is
I need unique value for every key press & release events. For that I changed
the keyboard driver mode to MEDIUM_RAW, Before I exit from my program, I am
restoring it back to normal mode. When I came out of the program , my system
becomes unusable. That is, the keyboard driver is in some different mode,
thereby making me to do a hard-reset. (Ctl-Alt_Del wont works..some junk
char will be printed on the screen).I am using Linux 2.4.18. Does anyone
have idea about what is going wrong in my side. FYI: I am running this
program from a console.(No Xserver)  Below is the code.
Is there any other way to restore the system without doing hard-reset when
this sort of problem comes?

If this query is irrelevant to this list, I am sorry for posting it here.

With Regards
sampath

int main()
{
 unsigned char ch;
 int count = 0;
 int lastmode = 0;
 int STDIN = 0;

 if (ioctl(STDIN, KDGKBMODE, &lastmode) < 0)
 {
      perror(NULL);
     exit(1);
 }
 switch(lastmode)
 {
  case K_RAW:
   printf("raw \n");
   break;
  case K_MEDIUMRAW:
   printf("medium raw \n");
   break;
  case K_XLATE:
   printf("xlate \n");
   break;
  case K_UNICODE:
   printf("unicode \n");
   break;
  default:
   printf("unknown \n");
   break;
 }
 ioctl(STDIN, KDSKBMODE, K_MEDIUMRAW);

 read (STDIN, &ch, 1);  // PROBLEM COMES FROM THIS READ
 printf("%d\n", ch);

 ioctl(STDIN, I_FLUSH, FLUSHR);           // EVEN I TRIED TO FLUSH
 fflush(stdin);                                               // EVEN I
TRIED TO FLUSH; HOPING THIS WOULD DO SOMETHING

 ioctl(STDIN, KDSKBMODE, lastmode);
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
