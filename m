From: linas@austin.ibm.com
Date: Mon, 19 May 2003 11:07:46 -0500
To: guo_zhenglin <guo_zl9@hotmail.com>
Cc: linuxppc-embedded <linuxppc-dev@lists.linuxppc.org>
Subject: Re: help: why show "Oops: kernel access of bad area, sig: 11"
Message-ID: <20030519110746.B33270@forte.austin.ibm.com>
References: <Law14-OE57bZ2ntWEqp00015e5b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Law14-OE57bZ2ntWEqp00015e5b@hotmail.com>; from guo_zl9@hotmail.com on Mon, May 19, 2003 at 04:33:49PM +0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, May 19, 2003 at 04:33:49PM +0800, guo_zhenglin wrote:
>       Serial driver version 5.05c (2001-07-08) with no serial options
> enabled
>     Oops: kernel access of bad area, sig: 11
>     NIP: C0076F0C XER: 80009E6C LR: C007B620 SP: C017DE80 REGS: c017ddd0
> TRAP: 0300d
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 000003F9, DSISR: 00018469
> TASK = c017c000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C017DE80 C017C000 C017DE88 00000001 00000000 C0D203B8
> 000003F8
> GPR08: 00000000 000003F8 00000000 00000000 0000000D FFFFFFFF C007AC70
> C007A4C4
> GPR16: C0079010 C0079CDC C007A5E0 C00770A8 C007701C C007A154 C00790E0
> C0079058
> GPR24: C0079D64 C0078F90 C0078F78 C00F28F8 C00F28F8 C011A76C C011A830
> C017DE88
> Call backtrace:
> C0011AE4 C0101028 C00FA5FC C00FA644 C00022CC C0006BE4
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 180 seconds..


You need to use System.map to figure out what routine this crashed in.
You need a backtrace/stack dump

Then you need to create assembly for the file in question:
gcc -Wa,ah, -Wa,al

and figure out what the assembly was doing when it crashed.  And then
read the source code to see why.

KDB makes this a *lot* easier.

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
