From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Date: Fri, 24 Aug 2001 12:28:31 +0200
Message-Id: <20010824102831.14636@smtp.adsl.oleane.com>
In-Reply-To: <3B85E0D2.21BC306E@mvista.com>
References: <3B85E0D2.21BC306E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Some more progress (well, no much luck actually)

After discussing with Paulus,

I've removed the special case for flush_icache_page() in pgtable.h
for 4xx, and moved the flush to set_pte. The PG_arch_1 bit is used
to determine if a page is cache clean or not, so we use it.

We should even be able to not flush all the cache here but only
the possible "synonyms" as we know the real address.

It still doesn't work :(

When I try to boot a MV "Journeyman" distro, it dies in ld.so, with
the error

BUG IN DYNAMIC LINKER ld.so: rtld.c: 614: dl_main: Assertion
'dl_rtld_map.l_libname' failed!

I still have to look in the ld.so source what it means exactly,
but something is definitely wrong here.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
