To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SELF: ramdisk which required libraries if ...? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 11 Jan 2003 14:47:50 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC0602F@SNCMAIL>
Date: Sat, 11 Jan 2003 21:18:43 +0100
Message-Id: <20030111201848.9E383C6559@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jim,

in message <DB0585C9F6F9D411BE8F00D0B7896A4CC0602F@SNCMAIL> you wrote:
>
> I am wondering what libraries are required if you compile with uclibc that
> has shared libraries compiled out ...
> Do I need some, none, or all?

I'm afraid you will have to try this out yourself.

> To make my life easy here is a list of libraries ... which would I need ?

Making your life  easy  and  saving  memory  footprint  by  compiling
against uclibc are two ends of the scale.

Basicly you have three options:

* Use the SELF that comes  with  our  ELDK,  and  the  commands  from
  SELF.spec to build it yourself.

  This gives you most of "making your life easy" as it  will  include
  only such tools and libraries that are already present in the ELDK,
  i.  e.  there  is  no  compilation  eeded  at all, and since we use
  "genext2fs" to build the ramdisk image  you  don't  need  any  root
  permissions.

  You will pay for this comfort by the memory footprint:  we  include
  standard tools like login with PAM support, xinetd, etc.

  On the other hand, this also gives you extended  functionality  and
  security.

* Use the SELF from our FTP server.

  Here you will have to spend much more work, as  you  will  need  to
  download a couple of packages, and the Makefile will compile every-
  thing that goes into the ramdisk image fresh from scratch.

  You benefit from this  additional  work  with  a  somewhat  smaller
  memory footprint.

* Modify SELF to build against ulibc.

  This is where you give up "making your life easy" and  go  for  low
  memory footprint. I'm looking forward to receiving your patches :-)


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
