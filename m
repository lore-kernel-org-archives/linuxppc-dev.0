Message-Id: <v04003a20b642c8d1ea1a@[24.70.162.12]>
In-Reply-To: <Pine.HPX.4.10.10011231227170.13127-100000@gra-ux1.iram.es>
References: 
 <Pine.LNX.4.10.10011231212270.18581-100000@zirkon.biophys.uni-duesseldorf.
 de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 23 Nov 2000 07:32:55 -0600
To: Gabriel Paubert <paubert@iram.es>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: apmd and other archs
Cc: Avery Pennarun <apenwarr@worldvisions.ca>, daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:37 AM -0600 11/23/2000, Gabriel Paubert wrote:
[...]
>I agree that power management status/log should go to /var. On the other
>hand /etc has to be on the root fs for several reasons (/etc/inittab among
>others is quite important): IOW you don't use a separate mount point for
>/etc unless you want to play dirty tricks with init.
>
>Of cuorse there is a precedent for modifying /etc: /etc/mtab, but
>admittedly for good reasons. mount also puts lock files in /etc and has to
>have these funky option (-n and -f) to work around the chicken and egg
>problem of initial read only root filesystem mount by the kernel. Once you
>have these option I don't see any reason not to have /var/mtab instead for
>example but maybe I miss something.
>
>Now /etc/mtab is also somewhat redundant with /proc/mounts. Actually you
>should be able to link /etc/mtab to /proc/mounts but it raises a lot of
>problems and does not work satifactorily in my experience.
[...]

I think technically the /proc filesystem is optional. Requiring /proc for
mount to function gives you another fun chicken + egg of how the heck do
you then mount /proc on startup? ;)

At the risk of drifting way off topic, it might be worth looking at
rewriting mount and fellow /etc/mtab users to just never need to use a file
like /etc/mtab. I can particularily recall a few times where a stale,
unwritable /etc/mtab made some system reconfiguration and/or system
recovery about 5 times more annoying than it needed to be.

30 years of unix tradition be damned, /etc/mtab sucks.


As for pmud, why not use a socket interface for everything? Using loopback
tcp  in one place and a file in another place seems a bit silly to me.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
