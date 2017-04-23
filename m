Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9xch6fbjzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 03:42:12 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3NHcciE013231
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 13:42:09 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a01auhpsj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 13:42:09 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 03:42:06 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3NHfvKk6095148
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 03:42:05 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3NHfWBb029512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 03:41:32 +1000
Date: Sun, 23 Apr 2017 17:41:11 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 3/7] kprobes: validate the symbol name provided during
 probe registration
To: Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
 <87inlxyoja.fsf@concordia.ellerman.id.au>
In-Reply-To: <87inlxyoja.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492968472.gwfhge4zw5.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of April 22, 2017 11:25:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>=20
>> When a kprobe is being registered, we use the symbol_name field to
>> lookup the address where the probe should be placed. Since this is a
>> user-provided field, let's ensure that the length of the string is
>> within expected limits.
>=20
> What are we actually trying to protect against here?
>=20
> If you ignore powerpc for a moment, kprobe_lookup_name() is just
> kallsyms_lookup_name().
>=20
> All kallsyms_lookup_name() does with name is strcmp() it against a
> legitimate symbol name which is at most KSYM_NAME_LEN.
>=20
> So I don't think any of this validation helps in that case?

It does:
https://patchwork.kernel.org/patch/9695139/

It is far too easy to cause a OOPS due to the above, though this is=20
root-only (for modules).

As I stated earlier, I think it is always a good practice to validate=20
inputs right on entry, rather than later. Code gets refactored,=20
different arch support gets added, and so on.

Doing this validation here ensures we don't have to worry about how we=20
process this later, or if another arch has to over-ride=20
kprobe_lookup_name().

>=20
> In the powerpc version of kprobe_lookup_name() we do need to do some
> string juggling, for which it helps to know the input is sane. But I
> think we should just make that code more robust by checking the input
> before we do anything with it.

Ok, I will fold those tests in with the powerpc implementation for now=20
and consider a patch against kallsyms_lookup_name(), like Masami=20
recommends.


- Naveen

=
