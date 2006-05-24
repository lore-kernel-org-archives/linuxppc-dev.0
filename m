Return-Path: <malik_mca2000@yahoo.co.in>
Received: from web8410.mail.in.yahoo.com (web8410.mail.in.yahoo.com
	[202.43.219.158]) by ozlabs.org (Postfix) with SMTP id D784C67B1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 18:14:50 +1000 (EST)
Message-ID: <20060524081447.12399.qmail@web8410.mail.in.yahoo.com>
Date: Wed, 24 May 2006 09:14:47 +0100 (BST)
From: sandeep malik <malik_mca2000@yahoo.co.in>
Subject: Re:Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
To: linuxppc-embedded@ozlabs.org, roger.larsson@norran.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-820277446-1148458487=:8940"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-820277446-1148458487=:8940
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Roger...
  Thanks for your response.....but in my case the application is causing this error....this is not coming from any kernel module but a user space application which is creating problem.....and in that application also i have replaced all double occurances with long but still the same error was being flashed......what i suspect is this error is no where related to the usage of floating point as i compiled following code and run the same on the 8325 board and the code was running without any issue.....
   
  #include "stdio.h"
  int main()
{
  int i=0;
float j= 1.2;
  float result;
  for(i=0; i<10; i++ )
{
  result = result * 2;
  }
  printf("\n result %f",result);
return 0;
  }

  The result was exactly what is expected.....so i think this is not related to floating point but might be some other issue......
   
  Are there any other scenarios which can lead to this message????
   
   
  Regards,
  Malik
   
   
  =====================================================
  > Hi All...
>
>   I am trying to run an application compiled with gcc toolchain gcc--3.4.3
> and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I
> am getting following error....
>
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>   floating point used in kernel (task=c0398410, pc=3184)
>
>   I was suspecting this error might be because the hardware is not
> supporting floating point operations and hence i tried a simple program in
> which I intentionally did some floating point operation but that program
> was running as expected. 
No, the warning is more serious than that.

Linux does not save floating point registers when entering kernel.
It might even optimize not to store/reload when doing a context switch.

If your kernel module is using floating point in your kernel code.
It will probably work on a processor not having floating point but will
break in mysterious ways on one supporting hardware floating point.

Do not use floating point in kernel. If you still have to you must take
extremely care.
  Turn off kernel preemption.
  Save FP registers.
  Do your stuff.
  Reload FP registers.
  Turn on preemption.
But the question is why would you have to?
Simple calculations can be done in fixed point, and complex calculations
does not belong in the kernel.

/RogerL


				
---------------------------------
  Yahoo! India Answers Share what your know-how and wisdom
 Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now
--0-820277446-1148458487=:8940
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Roger...</div>  <div>Thanks for your response.....but in my case the application is causing this error....this is not coming from any kernel module but a user space application which is creating problem.....and in that application also i have replaced all double occurances with long but still the same error was being flashed......what i suspect is this error is no where related to the usage of floating point as i compiled following code and run the same on the 8325 board and the code was running without any issue.....</div>  <div>&nbsp;</div>  <div>#include "stdio.h"</div>  <div>int main()<BR>{</div>  <div>int i=0;<BR>float j= 1.2;</div>  <div>float result;</div>  <div>for(i=0; i&lt;10; i++ )<BR>{</div>  <div>result =&nbsp;result * 2;</div>  <div>}</div>  <div>printf("\n result %f",result);<BR>return 0;</div>  <div>}<BR></div>  <div>The result was exactly what is expected.....so i think this is not related to floating point but might be some other issue......</div> 
 <div>&nbsp;</div>  <div>Are there any other scenarios which can lead to this message????</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Malik</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>=====================================================</div>  <div>&gt;<I> Hi All...<BR></I>&gt;<I><BR></I>&gt;<I>&nbsp;&nbsp; I am trying to run an application compiled with gcc toolchain gcc--3.4.3<BR></I>&gt;<I> and glibc -2.3.4 on PPC 8325 board running Linux 2.6.11....but some how I<BR></I>&gt;<I> am getting following error....<BR></I>&gt;<I><BR></I>&gt;<I>&nbsp;&nbsp; floating point used in kernel (task=c0398410, pc=3184)<BR></I>&gt;<I>&nbsp;&nbsp; floating point used in kernel (task=c0398410, pc=3184)<BR></I>&gt;<I>&nbsp;&nbsp; floating point used in kernel (task=c0398410, pc=3184)<BR></I>&gt;<I>&nbsp;&nbsp; floating point used in kernel (task=c0398410, pc=3184)<BR></I>&gt;<I>&nbsp;&nbsp; floating point used in kernel (task=c0398410,
 pc=3184)<BR></I>&gt;<I>&nbsp;&nbsp; floating point used in kernel (task=c0398410, pc=3184)<BR></I>&gt;<I><BR></I>&gt;<I>&nbsp;&nbsp; I was suspecting this error might be because the hardware is not<BR></I>&gt;<I> supporting floating point operations and hence i tried a simple program in<BR></I>&gt;<I> which I intentionally did some floating point operation but that program<BR></I>&gt;<I> was running as expected. <BR></I>No, the warning is more serious than that.<BR><BR>Linux does not save floating point registers when entering kernel.<BR>It might even optimize not to store/reload when doing a context switch.<BR><BR>If your kernel module is using floating point in your kernel code.<BR>It will probably work on a processor not having floating point but will<BR>break in mysterious ways on one supporting hardware floating point.<BR><BR>Do not use floating point in kernel. If you still have to you must take<BR>extremely care.<BR>&nbsp; Turn off kernel preemption.<BR>&nbsp; Save
 FP registers.<BR>&nbsp; Do your stuff.<BR>&nbsp; Reload FP registers.<BR>&nbsp; Turn on preemption.<BR>But the question is why would you have to?<BR>Simple calculations can be done in fixed point, and complex calculations<BR>does not belong in the kernel.<BR><BR>/RogerL<BR><!--endarticle--></div><p>
	

	
		<hr size=1></hr> 
 <a href="http://us.rd.yahoo.com/mail/in/mailanswersshare/*http://in.answers.yahoo.com/">Yahoo! India Answers</a> Share what your know-how and wisdom<br> 
Send free SMS to your Friends on Mobile from your Yahoo! Messenger <a href="http://us.rd.yahoo.com/mail/in/freesms/*http://messenger.yahoo.com/download.php">Download now</a>
--0-820277446-1148458487=:8940--
