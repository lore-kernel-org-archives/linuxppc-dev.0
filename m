Message-Id: <6.0.0.22.2.20031014132031.02dc4820@mail.lauterbach.com>
Date: Tue, 14 Oct 2003 13:34:58 +0200
To: Colin Leroy <colin@colino.net>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: Fw: [PATCH] Right-click modifier
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20031014122740.2a8a05a3.colin@colino.net>
References: <02cc01c39231$dce0d200$3cc8a8c0@ANOSP>
 <20031014093604.GC29143@suse.de>
 <20031014122740.2a8a05a3.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:27 14.10.2003, Colin Leroy wrote:

>On 14 Oct 2003 at 11h36, Olaf Hering wrote:
>
>Hi,
>
> > Its certainly a nice thing, but all this mouse button emulation stuff
> > should be handled in userland. Its just the question how and where.
>
>Any pointer about how it could be done?

Well, all this button emulation stuff currently is a hack that should go
away, so Olaf is right here. Colin's patch itself is unacceptable to the
kernel people, so it would be a benh-tree only solution at best.

But since there is now the possibility to "grab" (input_grab_device()) away
input devices from the input handler chain, one could write a input device
kernel module that grabs keyboard and 1/2-button mice devices, massages the
events and gives them back to the input layer via input_event(). I guess
this is the only in-kernel solution acceptable to the kernel people.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
