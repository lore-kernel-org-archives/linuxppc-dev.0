Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYDZV1HF7zF0Zr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 11:02:58 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12NxpjK059458
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Feb 2018 19:02:55 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fvw06ah7c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 19:02:54 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 19:02:53 -0500
Date: Fri, 2 Feb 2018 22:02:44 -0200
From: joserz@linux.vnet.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v5 0/1] Implements MMIO emulation for lvx/stvx instructions
References: <20180201181539.9650-1-joserz@linux.vnet.ibm.com>
 <20180202003018.GA27665@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180202003018.GA27665@fergus.ozlabs.ibm.com>
Message-Id: <20180203000244.GA24233@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2018 at 11:30:18AM +1100, Paul Mackerras wrote:
> On Thu, Feb 01, 2018 at 04:15:38PM -0200, Jose Ricardo Ziviani wrote:
> > v5:
> >  - Fixed the mask off of the effective address
> > 
> > v4:
> >   - Changed KVM_MMIO_REG_VMX to 0xc0 because there are 64 VSX registers
> > 
> > v3:
> >   - Added Reported-by in the commit message
> > 
> > v2:
> >   - kvmppc_get_vsr_word_offset() moved back to its original place
> >   - EA AND ~0xF, following ISA.
> >   - fixed BE/LE cases
> > 
> > TESTS:
> > 
> > For testing purposes I wrote a small program that performs stvx/lvx using the
> > program's virtual memory and using MMIO. Load/Store into virtual memory is the
> > model I use to check if MMIO results are correct (because only MMIO is emulated
> > by KVM).
> 
> I'd be interested to see your test program because in my testing it's
> still not right, unfortunately.  Interestingly, it is right for the BE
> guest on LE host case.  However, with a LE guest on a LE host the two
> halves are swapped, both for lvx and stvx:

Absolutely, here it's: https://gist.github.com/jrziviani/a65e71c5d661bffa8afcd6710fedd520
It basically maps an IO region and also allocates some memory from the
program's address space. Then I store to/load from both addresses and
compare the results. Because only the mmio load/store are emulated, I
use the regular load/store as a model.

> 
> error in lvx at byte 0
> was: -> 62 69 70 77 7e 85 8c 93 2a 31 38 3f 46 4d 54 5b
> ref: -> 2a 31 38 3f 46 4d 54 5b 62 69 70 77 7e 85 8c 93
> error in stvx at byte 0
> was: -> 49 50 57 5e 65 6c 73 7a 11 18 1f 26 2d 34 3b 42
> ref: -> 11 18 1f 26 2d 34 3b 42 49 50 57 5e 65 6c 73 7a
> 
> The byte order within each 8-byte half is correct but the two halves
> are swapped.  ("was" is what was in memory and "ref" is the correct
> value.  For lvx it does lvx from emulated MMIO and stvx to ordinary
> memory, and for stvx it does lvx from ordinary memory and stvx to
> emulated MMIO.  In both cases the checking is done with a byte by byte
> comparison.)

The funny thing is that I still see it right in both cases, so I believe
that my test case is incorrect. Example (host LE, guest LE):

====> VR0 after lvx
(gdb) p $vr0
{uint128 = 0x1234567855554444aaaabbbb87654321, v4_float = {
    -1.72477726e-34, -3.03283305e-13, 1.46555735e+13, 5.69045661e-28},
  v4_int32 = {-2023406815, -1431651397, 1431651396, 305419896}, v8_int16 = {
    17185, -30875, -17477, -21846, 17476, 21845, 22136, 4660}, v16_int8 = {33,
    67, 101, -121, -69, -69, -86, -86, 68, 68, 85, 85, 120, 86, 52, 18}}


address: 0x10030010
0x1234567855554444aaaabbbb87654321

====> VR0 after lvx from MMIO
(gdb) p $vr0
$3 = {uint128 = 0x1234567855554444aaaabbbb87654321, v4_float = {
    -1.72477726e-34, -3.03283305e-13, 1.46555735e+13, 5.69045661e-28},
  v4_int32 = {-2023406815, -1431651397, 1431651396, 305419896}, v8_int16 = {
    17185, -30875, -17477, -21846, 17476, 21845, 22136, 4660}, v16_int8 = {33,
    67, 101, -121, -69, -69, -86, -86, 68, 68, 85, 85, 120, 86, 52, 18}}

io_address: 0x3fffb7f70000
0x1234567855554444aaaabbbb87654321

I only see it wrong when I mess with copy order:

	if (vcpu->arch.mmio_vmx_copy_nums == /*from 1 to */ 2) {
		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(2)] = lo;
		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(3)] = hi;
	} else if (vcpu->arch.mmio_vmx_copy_nums == /*from 2 to */ 1) {
		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(0)] = lo;
		VCPU_VSX_VR(vcpu, index).u[kvmppc_get_vsr_word_offset(1)] = hi;
	}

then I get:

address: 0x1003b530010
0x1234567855554444aaaabbbb87654321
io_address: 0x3fff811a0000
0xaaaabbbb876543211234567855554444

Anyway, your suggestion works great and it's a way more elegant/easy to
understand. I'll send the next version with it.

Thank you very much for your patience and hints that helped me to
understand KVM better. :-)

> 
> Paul.
> 
