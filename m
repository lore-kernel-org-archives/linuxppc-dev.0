Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp2.smiths.com (smtp2.smiths.com [192.208.34.51])
	by ozlabs.org (Postfix) with ESMTP id E4F562BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 05:47:43 +1000 (EST)
Received: from COSSMGIMS01.email.corp.tld (unknown [10.225.225.177])
	by smtp2.smiths.com (Postfix) with ESMTP id 0EE241C000BC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 13:47:39 -0600 (MDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 22 Oct 2004 13:47:36 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB90F1B9@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Help on tuning the Linux kernel for soft real-time requirements
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=0D
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=0D
> Zajac Adam-AAZ004
> Sent: Friday, October 22, 2004 3:00 PM
> To: 'wd@denx.de'
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: Help on tuning the Linux kernel for soft=0D
> real-time requirements=0D
>=0D
> Wolfgang,
>=0D
> >I'm not exaclty sure I really understand what  you  are  asking  for.
> >Isn't  sometimes  missing  the  deadlines what the "soft" is=0D
> standing=0D
> >for? ;-)
>=0D
> I'm certainly not the one who would attempt to define the=0D
> distinction between hard and soft real-time requirements=0D
> (beyond the obvious notion of an absolute deterministic and=0D
> an average response time). Just used that term casually as we=0D
> wanted to meet application deadlines that were in order of=0D
> seconds with some small room for a response variation (+/-=0D
> milliseconds).
> What I referred to as "missed deadlines" were slips in order=0D
> of +/- 20 seconds. This was way out of line.
>=0D
> Do you know if sysstat RPM is available for PPC?
> It'd be nice to have tools like sar and iostat for debugging=0D
> my problem.
>=0D
> Regards,
> Adam

Hi Adam,

What you are quoting isn't a missed deadline in a soft real time system,
you are describing a full blown bug.  You are confusing your advisors by
mischaracterizing it.  Slips of a small number of milliseconds are
"missed deadlines."  Slips of 20 seconds are evidence of a full blown
bug such as interrupts being masked in the code and not unmasked (e.g.
an error path is taken that forgets to unmask the interrupts) or
priority inversion.

Priority inversion happens when a low priority task grabs a semaphore
which is then preempted by a higher priority task.  Meanwhile other high
priority tasks try to get the locking semaphore held by the low priority
task, but cannot get it because the low priority task has it locked and
other higher priority tasks prevent the low priority task from running
and releasing the semaphore.

I would be suspicious in your case of either priority inversion due to
different tasks printing to the serial port or of a miss-handling of
interrupt masking in the serial routine.

I would suggest you use the LTT.  My cohort in crime here says it works
well for this type of bug, although it can generate GOBS of data (as
Wolfgang pointed out).  Note that you can make custom log points and
insert them in both your driver and also your application code so you
can see what your application code is doing too when everything
paaaaaaaaaaaaaaaaaaaaaaaaaaaaaauses.

gvb


******************************************
The following messages are brought to you by the Lawyers' League of
IdioSpeak:

******************************************
The information contained in, or attached to, this e-mail, may contain=
 confidential information and is intended solely for the use of the=
 individual or entity to whom they are addressed and may be subject to=
 legal privilege.  If you have received this e-mail in error you should=
 notify the sender immediately by reply e-mail, delete the message from=
 your system and notify your system manager.  Please do not copy it for any=
 purpose, or disclose its contents to any other person.  The views or=
 opinions presented in this e-mail are solely those of the author and do=
 not necessarily represent those of the company.  The recipient should=
 check this e-mail and any attachments for the presence of viruses.  The=
 company accepts no liability for any damage caused, directly or=
 indirectly, by any virus transmitted in this email.
******************************************
