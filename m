From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras
 <paulus@linuxcare.com>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: success 2.4.0-test8 with latest bk
Date: Wed, 13 Sep 2000 14:45:16 +0200
Message-Id: <20000913124516.15351@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10009130011300.372-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009130011300.372-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Usually this means that some function/data is marked __init while it
must not.
>Quick verification: #undef __init / #define __init etc.
>
>Just wondering: wouldn't it be possible to write some tool to find such bugs?

Yup, we could probably, instead of freeing the __init section, mark it
unaccessible with the MMU. This would put us in xmon as soon as we try to
access one of these. I'm not sure if this can be done without disabling
the BAT mapping of the kernel, however. Well, of course, that would be a
DEBUG option, not a feature of the "standard" kernel.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
