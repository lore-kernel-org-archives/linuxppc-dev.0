Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDFCX1vTQzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 21:31:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org,
 Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH] powerpc/kprobes: refactor kprobe_lookup_name for safer
 string operations
In-Reply-To: <1493232011.n7d4slc7ao.astroid@naverao1-tp.none>
References: <20170425160711.15332-1-naveen.n.rao@linux.vnet.ibm.com>
 <20170426134118.d1d14c5e48e65f194b56f11d@kernel.org>
 <1493232011.n7d4slc7ao.astroid@naverao1-tp.none>
Date: Thu, 27 Apr 2017 21:31:50 +1000
Message-ID: <877f2613yx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Excerpts from Masami Hiramatsu's message of April 26, 2017 10:11:
>> On Tue, 25 Apr 2017 21:37:11 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>> -	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
>>> -	if (!addr && dot_appended) {
>>> -		/* Let's try the original non-dot symbol lookup	*/
>>> +	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
>>> +	if (ret >= 0)
>> 
>> Here, maybe you can skip the case of ret == 0. (Or, would we have
>> a symbol which only has "."?)
>
> Ah, indeed. Good point. We just need the test to be (ret > 0).
>
> Michael,
> If the rest of the patch is fine by you, would you be ok to make the 
> small change above? If not, please let me know and I'll re-spin. Thanks.

I'd rather you change it, test and then resend.

cheers
