Message-ID: <3F3AF502.2030300@mvista.com>
Date: Wed, 13 Aug 2003 21:33:38 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Mike G." <gohas@actinium.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic: No init found.?? Try passing init= option to kernel
References: <1060827870.1060.20.camel@localhost.localdomain>
In-Reply-To: <1060827870.1060.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike G. wrote:
> Hi there,
> Kernel panic: No init found.  Try passing init= option to kernel.

That message indicates one of a few things happened.

The first is it could not find any default init programs to run.

the second is whatever "init=" that you passed in was not found.

or...

third, the most common, you have a bad dependency, so when it tries to
run init the dynamic loader fails, (shell loader fails in the case of a
shell script.)  Something is causing the program not to run properly.

The way I usually debug this is to install ash.static on the system, set
my kernel command line to have init=/bin/ash.static..  boot up and then
attempt to run the "real" init manually so I can get the descriptive
error messages.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
