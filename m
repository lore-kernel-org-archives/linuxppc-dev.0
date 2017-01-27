Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v98lt3350zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 07:00:26 +1100 (AEDT)
Message-ID: <1485547137.2980.94.camel@kernel.crashing.org>
Subject: Re: ibmvtpm byteswapping inconsistency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Michal
 =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 Ashley Lai <ashleydlai@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Sat, 28 Jan 2017 06:58:57 +1100
In-Reply-To: <e518682f-e563-9533-9ffd-f465c662e998@linux.vnet.ibm.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <d55b06cc-cb7a-1ef1-05b7-d7d4114d0c48@linux.vnet.ibm.com>
 <1485481819.2980.82.camel@kernel.crashing.org>
 <e518682f-e563-9533-9ffd-f465c662e998@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-27 at 10:02 -0800, Tyrel Datwyler wrote:
> > The problem is that we are packing an in-memory structure into 2
> > registers and it's expected that this structure is laid out in the
> > registers as if it had been loaded by a BE CPU.
> 
> This is only the case if the cpu is BE. If the cpu is LE, regardless of
> the fact that our in memory structure is laid out BE, when we break it
> into 2 words each of those words needs to be loaded LE.

That doesn't make sense and doesn't match the code... The structure
needs to always have the same in-register layout regardless of the
endianness of the CPU, especially since the underlying hypervisor
will most likely be BE :-)

Thta's why the code does a be64_to_cpu() when loading it, this in
effect performs a "BE" load, which on a BE CPU is just a normal load
and on LE is a swap to compensate for the CPU loading it the "wrong way
around".

Cheers,
Ben.
