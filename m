Message-ID: <3BA8C8B4.5E386FDF@chinook.com>
Date: Wed, 19 Sep 2001 12:32:52 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Pedro Parrilla <pparrilla@prodys.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with remote debugging on MBX860
References: <3BA8C207.79FFF7CD@prodys.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've had luck with 'target remote /dev/<xxx>' instead of
extended-remote.  The following mod to the top-level Makefile helps,
too:

! CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2
-fno-strict-aliasing
! ifdef CONFIG_KGDB
! CFLAGS += -g -ggdb
! else
! CFLAGS += -fomit-frame-pointer
! endif

In addition, whenever I enabled kgdb I was getting an oops in
rs_8xx_interrupt sometime during boot due to info->tty being NULL - I
added a check for that and a return, and things seem to be fine.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
