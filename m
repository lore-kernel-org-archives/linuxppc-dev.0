Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40E23B03.5030701@opersys.com>
Date: Wed, 30 Jun 2004 00:01:07 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: brk() problem in glibc 2.3.2 on TQM860
References: <40DFB360.3090801@opersys.com>
In-Reply-To: <40DFB360.3090801@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


... Pilot error ...

Karim Yaghmour wrote:
> I've been having problems with brk() calls (like ones made by malloc()
> to the
> kernel) when using glibc 2.3.2 on a TQM860 (16MB RAM, 8MB of flash.)
> Take the
> following snippet of code for example:
>     for (i = 1, val = 10; i < 10; val = val * 10, i++) {
>         printf("Allocating %lu \n", val);
>         x = (void*) malloc(val);
>         memset(x, '\0', val);
>     }

It actually freezes in the memset() and the problem is the memset.S file in
glibc-2.3.2/sysdeps/powerpc/powerpc32/ which needs to be removed. I knew
this problem existed in older versions of glibc, but I had assumed that it
had been fixed in the newer versions ... I assumed wrong.

When the file is removed everything works fine.

Karim
--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
