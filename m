Message-ID: <3ECE5CAC.8040304@mvista.com>
Date: Fri, 23 May 2003 10:38:52 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ERR51 / ERR77 on IBM405GPr
References: <3ECDF370.7020808@elsoft.ch>
In-Reply-To: <3ECDF370.7020808@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Müller (ELSOFT AG) wrote:
> Hello
>
> According to the errata sheet, the IBM405GPr doesn't suffer from the
> ERR51 / CPU_190 and ERR77 / CPU_210 bugs as the IBM405GP does.
>
> But the workarounds are still enabled in "arch/ppc/config.in".
>
> Shouldn't there be something like this:
>
>   if [ "$CONFIG_405GPR" = "y" ]; then
>     define_bool CONFIG_IBM405_ERR51 n
>     define_bool CONFIG_IBM405_ERR77 n
>   fi

Right -- actually need to avoid defining the symbols at all (such as
removing ERR77 from the CONFIG_SYCAMORE case) since an "ifdef" check is
used (that should probably be fixed as well).  We've just run the same
kernel binary on 405GP "Walnut" and 405GPr "Sycamore" boards, so haven't
been cleaning up the 405GPr specifics.

--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
