From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>,
	Gabriel Paubert <paubert@iram.es>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Re: tlbia and PPC603
Date: Mon, 24 Jun 2002 06:02:40 +0200
Message-Id: <20020624040240.17519@192.168.4.1>
In-Reply-To: <20020625234314J.ekato@ees.hokudai.ac.jp>
References: <20020625234314J.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I learned ppc603 software hash table some extent.  And I finally
>noticed the bug in current arch/ppc/mm/ppc_mmc.c.  In old code, there
>was blr at hash_page[0] and did flush_icache_range() from hash_page[0]
>to hash_page[1].  But in current code, this code is removed when
>comparing CPU_FT_HPTE_TABLE.
>
>Adding this to current ppc_mmu.c have solved random crash both in
>Nubus Performa and UMAX C500.  And isync before tlbie and mtsrin seems
>to be not necessary.

Good catch !

We'll fix it asap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
