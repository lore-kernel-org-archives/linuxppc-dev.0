Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w91zZ6kY3zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 15:55:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] kprobes: validate the symbol name provided during
 probe registration
In-Reply-To: <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Sat, 22 Apr 2017 15:55:21 +1000
Message-ID: <87inlxyoja.fsf@concordia.ellerman.id.au>
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

> When a kprobe is being registered, we use the symbol_name field to
> lookup the address where the probe should be placed. Since this is a
> user-provided field, let's ensure that the length of the string is
> within expected limits.

What are we actually trying to protect against here?

If you ignore powerpc for a moment, kprobe_lookup_name() is just
kallsyms_lookup_name().

All kallsyms_lookup_name() does with name is strcmp() it against a
legitimate symbol name which is at most KSYM_NAME_LEN.

So I don't think any of this validation helps in that case?

In the powerpc version of kprobe_lookup_name() we do need to do some
string juggling, for which it helps to know the input is sane. But I
think we should just make that code more robust by checking the input
before we do anything with it.

cheers
