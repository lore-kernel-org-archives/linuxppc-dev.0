Date: Tue, 25 Jun 2002 23:43:12 +0900
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: tlbia and PPC603
References: <20020619031038.28719@smtp.wanadoo.fr> <Pine.LNX.4.33.0206201256050.27936-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0206201256050.27936-100000@gra-lx1.iram.es>
Message-Id: <20020625234314J.ekato@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you for information, Gabriel and Ben.

I learned ppc603 software hash table some extent.  And I finally
noticed the bug in current arch/ppc/mm/ppc_mmc.c.  In old code, there
was blr at hash_page[0] and did flush_icache_range() from hash_page[0]
to hash_page[1].  But in current code, this code is removed when
comparing CPU_FT_HPTE_TABLE.

Adding this to current ppc_mmu.c have solved random crash both in
Nubus Performa and UMAX C500.  And isync before tlbie and mtsrin seems
to be not necessary.


--
Etsushi Kato
ekato@ees.hokudai.ac.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
