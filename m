In-Reply-To: <19991025223613.011624@mailhost.mipsys.com>
Date: Tue, 26 Oct 1999 12:03:19 +0200
To: jmb@montana.edu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: iBook/UMA pre3
Message-Id: <19991026120319.024346@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a little mistake in my previous patch, if you intend to test on a
machine with a second PCI bridge (G4), in arch/ppc/kernel/pmac_pci.c, change

/* This one is for type 1 config accesses */
#define UNI_N_CFA1(bus, devfn, off)	\
	((((unsigned long)(bus)) << 16) \
	|(((unsigned long)(devfn)) << 8) \
	|(((unsigned long)(off)) & 0xFCUL))

to

/* This one is for type 1 config accesses */
#define UNI_N_CFA1(bus, devfn, off)	\
	((((unsigned long)(bus)) << 16) \
	|(((unsigned long)(devfn)) << 8) \
	|(((unsigned long)(off)) & 0xFCUL)) \
 | 1UL

I won't have time to post a new version until later this week.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
