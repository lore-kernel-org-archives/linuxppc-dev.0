From: Benjamin Herrenschmidt <bh40@calva.net>
To: <guillaume.laures@noos.fr>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: progress on l2cr
Date: Tue, 18 Jul 2000 10:03:55 +0200
Message-Id: <20000718080355.26687@mailhost.mipsys.com>
In-Reply-To: <3973882B.1C9A581E@noos.fr>
References: <3973882B.1C9A581E@noos.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>Here are two patches against current stable tree, the first,
>l2cr-display-gom.diff, fixes the ouput of "cat /proc/sys/kernel.l2cr"
>according to M Lanners' patch for G3, and according to the Motorola 7400
>Users' Manual.
>Tested on G4, but not G3 yet. It should be clean and harmful anyway.
>
>The second, l2cr-cmdline-gom.diff, is a try to enable "l2cr=xx" kernel
>command line option.
>All is fine if you don't put the option, and hangs at boot with
>something like this: l2cr=0xb5100000.
>Since when I tried to kill calls to __set_L2CR in ppc_setup_l2cr()
>commenting the following two lines:
> _set_L2CR(0);  /* disable cache */
> _set_L2CR(val);  /* enable it */
>it stills hangs at the same point, I guess the way I call
>ppc_setup_l2cr() is wrong. I couldn't find documentation on this, but I
>figured out reading init/main.c that doing this would be sufficient,
>tell me were I'm wrong :

Try my current rsync tree. I merged in some new code from PowerLogix in
the _set_L2CR() function that work around a few CPU erratas and increase
a few things.

You'll notice that when calling _set_L2CR(x) with x!=0, I always OR x
with the invalidate bit to force an invalidation. It's not necessary to
wait for the invaldation to complete inside the ppc_htab.c code however
since it's done inside the _set_L2CR() function in misc.S

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
