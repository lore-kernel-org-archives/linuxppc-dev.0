From: jkl@miacid.net
Date: Wed, 2 Jan 2002 16:55:08 -0800 (PST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix 
In-Reply-To: <25193.1010018130@redhat.com>
Message-ID: <Pine.BSI.4.10.10201021651180.29444-100000@hevanet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't have the ANSI standard in front of me, isn't it the case that
casting a pointer to/from an integer is implementation defined, rather
than undefined, so people who need to do pointer arithmatic that relies on
the machine's memory map can do
 (void *)(((int)p) + some_magic_number)

and have some sort of assurance that the compiler won't mess with it?

-JKL


On Thu, 3 Jan 2002, David Woodhouse wrote:

>
> (cc list trimmed)
>
> alan@lxorguk.ukuu.org.uk said:
> >  If you want a strcpy that isnt strcpy then change its name or use a
> > different language 8)
>
> The former is not necessarily sufficient in this case. You've still done the
> broken pointer arithmetic, so even if the function isn't called strcpy() the
> compiler is _still_ entitled to replace it with a call to memcpy() or even
> machine_restart() before sleeping with your mother and starting WW III.
>
> Granted, it probably _won't_ do any of those today, but you should know
> better than to rely on that.
>
> What part of 'undefined behaviour' is so difficult for people to understand?
>
> --
> dwmw2
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
