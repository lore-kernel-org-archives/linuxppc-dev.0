Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v9N2Y60KszDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 15:28:53 +1100 (AEDT)
Message-ID: <1485577703.2980.104.camel@kernel.crashing.org>
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
Date: Sat, 28 Jan 2017 15:28:23 +1100
In-Reply-To: <48dc15a0-eaba-29e4-f39e-500177f98638@linux.vnet.ibm.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <d55b06cc-cb7a-1ef1-05b7-d7d4114d0c48@linux.vnet.ibm.com>
 <1485481819.2980.82.camel@kernel.crashing.org>
 <e518682f-e563-9533-9ffd-f465c662e998@linux.vnet.ibm.com>
 <1485547137.2980.94.camel@kernel.crashing.org>
 <48dc15a0-eaba-29e4-f39e-500177f98638@linux.vnet.ibm.com>
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

On Fri, 2017-01-27 at 12:32 -0800, Tyrel Datwyler wrote:
> Its possible being the end of the week I'm just a little dense, but
> wouldn't be64_to_cpu() imply that we are byte-swapping something that is
> already, or supposedly already, in BE format to cpu endianness? Which on
> a BE cpu I would expect a no-op, and on a LE cpu the 64bit word to have
> been swapped from BE --> LE?

It's in BE format in memory. In LE mode, loading it into a register will
get it the wrong way around, thus we have to swap it again. Once in a
register it has no "endianness" per-se, what matters is that the act
of loading from memory to a register would have loaded it the wrong
way around in LE.

> In my eyes the code does seem to support what I've argued. The same
> thing is done in the scsi VIO drivers. The CRQ structure is laid out and
> annotated BE. We use cpu_to_be() calls to load any non 8bit field.
> Finally, each word is swapped to cpu endian when we hand it off for the
> hcall.
> 
> from ibmvfc_send_event():
> 
>         __be64 *crq_as_u64 = (__be64 *) &evt->crq;
> 
>         <..snip..>
> 
>         if ((rc = ibmvfc_send_crq(vhost, be64_to_cpu(crq_as_u64[0]),
>                                   be64_to_cpu(crq_as_u64[1])))) {
> 
> Again, maybe I'm missing something.
