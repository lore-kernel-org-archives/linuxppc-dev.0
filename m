To: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: (X-Window) Yellowdog RPMs within ELDK? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 May 2003 17:39:55 +0200."
             <30C145E544071F4FB8B627789F7910BD32BE04@csy-exchange1.giat.intra>
Date: Mon, 12 May 2003 18:08:01 +0200
Message-Id: <20030512160806.54AAFC6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Albert,

in message <30C145E544071F4FB8B627789F7910BD32BE04@csy-exchange1.giat.intra> you wrote:
>
> I need to install X libraries and apps on
> our custom 855T-based board running Linux.
> Since ELDK derives from Yellowdog, I thought
> I'd use RPMs from Yellowdog.

Please note that "derives from" does not mean "is compatible with".

> Trouble is, if I 'ppc-rpm' an YDL package,
> I get an architecture mismatch (which is
> not surprising, all ELDK packages being
> 'ppc_8xx' while YDL packages are 'ppc').

This is an indication of RPMs being not compatible.

You CANNOT use a "standard" PowerPC RPM and install it  on  a  MPC8xx
(ppc_8xx)  system.  If  you  try  to do so you will just see that the
tools will not work (crash and/or produce wrong results).

One of the important  differences  is  that  the  "standard"  PowerPC
distributions  (like  YD) assume that there is a hardware FPU on your
CPU, which is not the case on the MPC8xx. This  must  be  taken  into
account when building any library and application.


You will have to use the source RPMs instead, and  rebuild  from  the
sources.  See  section  "8.2. Rebuilding Target Packages" in the ELDK
documentation. Note that in almost all cases you will  have  to  make
some adaptions to the RPM spec file.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A supercomputer is a machine that runs an endless loop in 2 seconds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
