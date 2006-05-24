Return-Path: <malik_mca2000@yahoo.co.in>
Received: from web8408.mail.in.yahoo.com (web8408.mail.in.yahoo.com
	[202.43.219.156]) by ozlabs.org (Postfix) with SMTP id 00FE5679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 22:30:10 +1000 (EST)
Message-ID: <20060524123007.34251.qmail@web8408.mail.in.yahoo.com>
Date: Wed, 24 May 2006 13:30:06 +0100 (BST)
From: sandeep malik <malik_mca2000@yahoo.co.in>
Subject: Re: Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
To: Roger Larsson <roger.larsson@norran.net>, linuxppc-embedded@ozlabs.org
In-Reply-To: <200605241148.38708.roger.larsson@norran.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-258835653-1148473806=:33888"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-258835653-1148473806=:33888
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 
  >It might be the application who runs, calls kernel for output, drivers used
>for output uses floating point.
>No application running => no floating point exceptions...
Yes even I do agree with this point.....and need ur help how to check this coz
  the main reason is that the error is not consistently coming from one particular point but the location keeps on changing......
  if we try to debug and remove from one point it start coming from some other point in the application......
   
  >Some driver, most likely your if you have made any yourself is
>using floating point.
>serial, console, ethernet drivers?
No I am not running any such drivers which are new and can be suspected 
  all the drivers used are fully tested and working well with all other applications...
   
  >pc = 3184 (in hex)
>Now check your System.map
>The routine with the closest lower address is your main suspect,
>the use of inlines can blur this...
>(the task pointer is not that useful, they should have converted it
>to process id)
  Even this pc value is very less. I think it should be in the range of c0000000 - c0233e38(range I got from system.map file)....
  if we think pc is returning the four LSB's even then it is not giving any such clue 
  as there are only ISR's defined in arc/ppc/kernel/head.S which are lying close to this address
   
   
  Regards,
  Malik

Roger Larsson <roger.larsson@norran.net> wrote:
  On onsdag 24 maj 2006 10.14, you wrote:
> Hi Roger...
> Thanks for your response.....but in my case the application is causing
> this error....
It might be the application who runs, calls kernel for output, drivers used
for output uses floating point.
No application running => no floating point exceptions...

> The result was exactly what is expected.....so i think this is not
> related to floating point but might be some other issue......
Some driver, most likely your if you have made any yourself is
using floating point.
serial, console, ethernet drivers?


>
> Are there any other scenarios which can lead to this message????

Not unless the exception is setup wrong - I would not bet on that.

Lets trace it:
> > floating point used in kernel (task=c0398410, pc=3184)
This message is generated in ./arch/ppc/kernel/head.S

pc = 3184 (in hex)
Now check your System.map
The routine with the closest lower address is your main suspect,
the use of inlines can blur this...
(the task pointer is not that useful, they should have converted it
to process id)

/RogerL


				
---------------------------------
  Yahoo! India Answers Share what your know-how and wisdom
 Send free SMS to your Friends on Mobile from your Yahoo! Messenger Download now
--0-258835653-1148473806=:33888
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>&nbsp;</div>  <div>&gt;It might be the application who runs, calls kernel for output, drivers used<BR>&gt;for output uses floating point.<BR>&gt;No application running =&gt; no floating point exceptions...<BR>Yes even I do agree with this point.....and need ur help how to check this coz</div>  <div>the main reason is that the error is not consistently coming from one particular point but the location keeps on changing......</div>  <div>if we try to debug and remove from one point it start coming from some other point in the application......</div>  <div>&nbsp;</div>  <div>&gt;Some driver, most likely your if you have made any yourself is<BR>&gt;using floating point.<BR>&gt;serial, console, ethernet drivers?<BR>No I am not running any such drivers which are new and can be suspected </div>  <div>all the drivers used are fully tested and working well with all other applications...</div>  <div>&nbsp;</div>  <div>&gt;pc = 3184 (in hex)<BR>&gt;Now check your
 System.map<BR>&gt;The routine with the closest lower address is your main suspect,<BR>&gt;the use of inlines can blur this...<BR>&gt;(the task pointer is not that useful, they should have converted it<BR>&gt;to process id)</div>  <div>Even this pc value is very less. I think it should be in the range of c0000000 - c0233e38(range&nbsp;I got from system.map file)....</div>  <div>if we think pc is returning the four LSB's even then it is not giving any such clue </div>  <div>as there are only ISR's defined in arc/ppc/kernel/head.S which are lying close to this address</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Malik<BR><BR><B><I>Roger Larsson &lt;roger.larsson@norran.net&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On onsdag 24 maj 2006 10.14, you wrote:<BR>&gt; Hi Roger...<BR>&gt; Thanks for your response.....but in my case the application is causing<BR>&gt; this
 error....<BR>It might be the application who runs, calls kernel for output, drivers used<BR>for output uses floating point.<BR>No application running =&gt; no floating point exceptions...<BR><BR>&gt; The result was exactly what is expected.....so i think this is not<BR>&gt; related to floating point but might be some other issue......<BR>Some driver, most likely your if you have made any yourself is<BR>using floating point.<BR>serial, console, ethernet drivers?<BR><BR><BR>&gt;<BR>&gt; Are there any other scenarios which can lead to this message????<BR><BR>Not unless the exception is setup wrong - I would not bet on that.<BR><BR>Lets trace it:<BR>&gt; &gt; floating point used in kernel (task=c0398410, pc=3184)<BR>This message is generated in ./arch/ppc/kernel/head.S<BR><BR>pc = 3184 (in hex)<BR>Now check your System.map<BR>The routine with the closest lower address is your main suspect,<BR>the use of inlines can blur this...<BR>(the task pointer is not that useful, they
 should have converted it<BR>to process id)<BR><BR>/RogerL<BR></BLOCKQUOTE><BR><p>
	

	
		<hr size=1></hr> 
 <a href="http://us.rd.yahoo.com/mail/in/mailanswersshare/*http://in.answers.yahoo.com/">Yahoo! India Answers</a> Share what your know-how and wisdom<br> 
Send free SMS to your Friends on Mobile from your Yahoo! Messenger <a href="http://us.rd.yahoo.com/mail/in/freesms/*http://messenger.yahoo.com/download.php">Download now</a>
--0-258835653-1148473806=:33888--
