Message-ID: <3A8C5C9E.4C02D1AC@mvista.com>
Date: Thu, 15 Feb 2001 14:47:58 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
Cc: frowand@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: calling giveup_altivec on machine with no altivec!?
References: <20010215160658.P26702@altus.drgw.net> <3A8C5613.662D35DA@mvista.com> <20010215163356.Q26702@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:


> > Is it possible that the MSR had the MSR_VEC bit set at some point?  One
> > IBM processor user's manual says "the reserved fields should be written
> > as 0 and read as __undefined__.  This is, when writing to a register with
> > a reserved field, write a 0 to the reserved field.  When reading from a
> > register with a reserved field, ignore that bit."


> In either case, if that's what the IBM manuals say, then the code is
> incorrect and should probably be re-done to check that it's actually
> running on a kernel with an altivec unit. Any suggestions on the best way
> to fix it?

Assuming a CONFIG_ALTIVEC flag (or equivalent) existed, then in processor.h:

#ifdef CONFIG_ALTIVEC
#define MSR_VEC         (1<<25)
#else
#define MSR_VEC         (0)
#endif

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
