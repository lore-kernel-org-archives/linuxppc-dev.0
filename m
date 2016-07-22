Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rx2cx05z4zDqTF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 06:41:52 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6MKcxFx147161
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:41:50 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24bhv1k8ps-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:41:50 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 22 Jul 2016 17:41:48 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A96831DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:41:37 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6MKfjCw4145376
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:41:45 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6MKfiWj002577
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:41:45 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Vivek Goyal <vgoyal@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 22 Jul 2016 17:41:40 -0300
In-Reply-To: <878twutmaj.fsf@concordia.ellerman.id.au>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4197460.etrDupniY8@hactar> <878twutmaj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1732711.nTAkJm8nA3@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 22 Juli 2016, 12:54:28 schrieb Michael Ellerman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > So even if not ideal, the solution above is desirable for powerpc. We
> > would like to preserve the ability of allowing userspace to pass
> > parameters to the OS via the DTB, even if secure boot is enabled.
> > 
> > I would like to turn the above into a proposal:
> > 
> > Extend the syscall as shown in this RFC from Takahiro AKASHI, but
> > instead of accepting a complete DTB from userspace, the syscall accepts
> > a DTB containing only a /chosen node. If the DTB contains any other
> > node, the syscall fails with EINVAL. If the DTB contains any subnode in
> > /chosen, or if there's a compatible or device_type property in /chosen,
> > the syscall fails with EINVAL as well.
> > 
> > The kernel can then add the properties in /chosen to the device tree
> > that it will pass to the next kernel.
> > 
> > What do you think?
> 
> I think we will inevitably have someone who wants to pass something
> other than a child of /chosen.
> 
> At that point we would be faced with adding yet another syscall, or at
> best a new flag.
> 
> I think we'd be better allowing userspace to pass a DTB, and having an
> explicit whitelist (in the kernel) of which nodes & properties are
> allowed in that DTB.

Sounds good to me.

> For starters it would only contain /chosen/stdout-path (for example).
> But we would be able to add new nodes & properties in future.

If we allow things outside of chosen, we can keep the offb.c hook in 
Petitboot and whitelist the framebuffer properties it adds to the vga node.

> The downside is userspace would have no way of detecting the content of
> the white list, other than trial and error. But in practice I'm not sure
> that would be a big problem.

For our use case in OpenPower I don't think it would be a problem, since the 
userspace and the kernel are developed together.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
