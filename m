Date: Fri, 14 Dec 2001 11:16:20 -0800
From: Jason R Thorpe <thorpej@wasabisystems.com>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Daniel Jacobowitz <drow@mvista.com>,
	Kevin Buettner <kevinb@redhat.com>, gdb@sources.redhat.com,
	ezannoni@cygnus.com, fsirl@kernel.crashing.org, paulus@samba.org
Subject: Re: AltiVec register ptrace support
Message-ID: <20011214111620.U9607@dr-evil.shagadelic.org>
Reply-To: thorpej@wasabisystems.com
References: <20011207173434.A28783@nevyn.them.org> <Pine.GSO.4.40.0112141249070.21737-100000@softail.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.40.0112141249070.21737-100000@softail.somerset.sps.mot.com>; from kumar.gala@motorola.com on Fri, Dec 14, 2001 at 12:52:33PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 14, 2001 at 12:52:33PM -0600, Kumar Gala wrote:

 > Is there any reason that we can not spport both methods.  There are
 > applications in which having the ability to get all the registers is a
 > single syscall is a major performance improvement.

I'll chime in...

Other systems that support ptrace(2) don't have PEEK/POKE/READ_U/WRITE_U
methods.

I'm currently working on AltiVec for NetBSD/powerpc, and ptrace(2) interface
for AltiVec is going to look like:

	PT_GETALTIVECREGS
	PT_SETALTIVECREGS

...both of which using the following structure as an argument:

	struct vreg {
		uint32_t vreg[32][4];	/* vector register contents */
		register_t vscr;	/* vector status and control reg */
		register_t vrsave;	/* SPR 238 */
	};

This is consistent with how e.g. SSE/SSE2 registers are handled on
NetBSD/i386 (PT_GETXMMREGS/PT_SETXMMREGS).

--
        -- Jason R. Thorpe <thorpej@wasabisystems.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
