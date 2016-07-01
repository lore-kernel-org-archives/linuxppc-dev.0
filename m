Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rh1hz4SmqzDql7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 02:15:15 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61GEjdM066628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:15:12 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23w76pxy7y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 12:15:12 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 13:15:10 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, linuxppc-dev@lists.ozlabs.org
Cc: petitboot@lists.ozlabs.org, "George C. Wilson" <ltcgcw@us.ibm.com>,
 Dave Heller <hellerda@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: device tree passing feature
Date: Fri, 01 Jul 2016 13:15:06 -0300
In-Reply-To: <1467337581.5491.15.camel@mendozajonas.com>
References: <5378248.F712oD97Cs@hactar>
 <1467337581.5491.15.camel@mendozajonas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2289227.FYhGr4BFNM@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Samuel,

Thanks for your response.

Am Freitag, 01 Juli 2016, 11:46:21 schrieb Samuel Mendoza-Jonas:
> On Thu, 2016-06-30 at 11:27 -0300, Thiago Jung Bauermann wrote:
> > I have a question about the petitboot feature which allows the user to
> > specify a device tree blob to pass to the target OS being loaded. What
> > is
> > the use case for it? Is it a debugging and development aid, or do you
> > expect it be useful in a production environment?
> 
> Passing the dtb isn't really a Petitboot feature, rather part of how
> kexec works for PowerPC and ARM. Petitboot may make modifications to, or
> replace the dtb, but the method via with the target kernel obtains its
> device-tree is kexec. So I suspect you would have to say it is mandatory
> for production.

Right. I already have a working kexec_file_load implementation [1], and what 
I'm doing in my patch set is taking the device tree that was used to boot 
the current kernel and modifying it as necessary to pass it to the next 
kernel.

My question is: is there any need in a production environment for userspace 
to provide a different device tree for the next kernel, or can the currently 
running kernel always use the device tree that it received when it was 
booted?

So one new piece of information for me is that Petitboot makes modifications 
to the dtb. Does it do that only if the system administrator provided a 
custom dtb (either via the boot options screen or a configuration file), or 
can it change/replace the dtb even if the system administrator didn't 
provide a custom dtb? Which modifications does Petitboot make?

> > I ask this because I'm implementing the kexec_file_load system call for
> > powerpc, and given its prototype:
> > 
> > long kexec_file_load(int kernel_fd, int initrd_fd, unsigned long
> > cmdline_len, const char *cmdline_ptr, unsigned long flags)
> > 
> > It wouldn't be very straightforward to allow the caller to specify a
> > device tree blob, so I have to ask how necessary such a feature is.
> 
> Yep, I think the problem is kexec_file_load was first implemented with a
> focus on x86 where this isn't an issue, and now we need to consider what
> to do :)

Yes, that's true. I was able to make it work on powerpc even with that x86 
bias, but now I'm wondering if that's enough or not.

> We are definitely going to need a way to pass the device-tree to the
> target kernel - whether we do that by changing the prototype for
> kexec_file_load() PowerPC and ARM, or by dealing with it some other way
> I'm not sure.

Do you say definitely because the kexec'd kernel needs to be passed a device 
tree, or is it because userspace needs to have some control over the device 
tree that the kexec'd kernel receives?

> Sounds like the start of a interesting conversation on the
> linuxppc-dev list :)

Indeed. :-) I'm copying linuxppc-dev here just in case.

A conversation about this just started in the kexec mailing list (I'm 
copying the linuxppc-dev mailing list in my response as well):

https://lists.infradead.org/pipermail/kexec/2016-July/016279.html

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-June/144658.html
