Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47561ECAAD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Sep 2022 15:15:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJPjl3BQ1z3bkk
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Sep 2022 01:15:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJPjJ1q0Vz2x9J
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2022 01:14:43 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 281FBJ1H024415;
	Thu, 1 Sep 2022 10:11:19 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 281FBHnO024414;
	Thu, 1 Sep 2022 10:11:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 1 Sep 2022 10:11:17 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on ppc
Message-ID: <20220901151117.GE25951@gate.crashing.org>
References: <20220829055223.24767-1-sv@linux.ibm.com> <20220829055223.24767-16-sv@linux.ibm.com> <2fb92e17-2ad5-9732-560c-a7321e6a2528@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fb92e17-2ad5-9732-560c-a7321e6a2528@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "mingo@redhat.com" <mingo@redhat.com>, Sathvika Vasireddy <sv@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>, "jpoimboe@redhat.com" <jpoimboe@redhat.com>, "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>, "mbenes@suse.cz" <mbenes@suse.cz>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 01, 2022 at 09:32:46AM +0000, Christophe Leroy wrote:
> Le 29/08/2022 à 07:52, Sathvika Vasireddy a écrit :
> > +int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
> > +			    unsigned long offset, unsigned int maxlen,
> > +			    unsigned int *len, enum insn_type *type,
> > +			    unsigned long *immediate,
> > +			    struct list_head *ops_list)
> > +{
> > +	u32 insn;
> > +
> > +	*immediate = 0;
> > +	insn = bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
> > +	*len = 4;
> 
> Should be *len = 8 when insn >> 26 == 1.

But please use ppc_inst_prefixed().  And just use ppc_inst_len() here?

Not having convenience abstraction functions like that will give you
much more work in the future -- currently all prefix insns use primary
opcode 1, sure, and nothing else does; but this can change.


Segher
