From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
Date: Tue, 30 Oct 2001 20:28:30 +0100
Message-Id: <20011030192830.7817@smtp.wanadoo.fr>
In-Reply-To: <20011030121221.E13806@altus.drgw.net>
References: <20011030121221.E13806@altus.drgw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>Then, when I tried to log in over serial console, the login process
>appeared to die after I entered 'root'.  If I kept trying, I would
>occasional actually get a password prompt.
>
>
>I think there's something going wrong either in the cache flush avoidance
>stuff, or in the generic smp VM.
>
>(I'm going to finally update linuxppc_2_4 for MTX SMP later today, so I'll
>can hopefully find out if it's a generic VM problem or not)

It's pre5 ? I think Tom's fix is wrong. It should probably be
copy_user_page or copy_cow_page (I use the last one). Without that,
the cache avoidance will probably win a direct ticket to hell ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
