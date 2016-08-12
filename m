Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9RGv49nHzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 10:54:15 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C0rvHs100552
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:54:12 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rmj7h039-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:54:12 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 21:54:09 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id F0B83352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:53:45 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7C0s6FV13762978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:54:06 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7C0s5c5004844
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:54:06 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 11/13] powerpc: Allow userspace to set device tree
 properties in kexec_file_load
Date: Thu, 11 Aug 2016 21:54:02 -0300
In-Reply-To: <1470962700.2570.6.camel@mendozajonas.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-12-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470962700.2570.6.camel@mendozajonas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1516604.QKHlMVtQ9l@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Sam,

Thanks for the quick response.

Am Freitag, 12 August 2016, 10:45:00 schrieb Samuel Mendoza-Jonas:
> On Thu, 2016-08-11 at 20:08 -0300, Thiago Jung Bauermann wrote:
> > @@ -908,4 +909,245 @@ bool find_debug_console(const void *fdt, int
> > chosen_node) return false;
> >  }
> >  
> > +/**
> > + * struct allowed_node - a node in the whitelist and its allowed
> > properties. + * @name:              node name or full node path
> > + * @properties:                NULL-terminated array of names or
> > name=value pairs + *
> > + * If name starts with /, then the node has to be at the specified path
> > in + * the device tree (including unit addresses for all nodes in the
> > path). + * If it doesn't, then the node can be anywhere in the device
> > tree. + *
> > + * An entry in properties can specify a string value that the property
> > must + * have by using the "name=value" format. If the entry ends with
> > =, it means + * that the property must be empty.
> > + */
> > +static struct allowed_node {
> > +       const char *name;
> > +       const char *properties[9];
> > +} allowed_nodes[] = {
> > +       {
> > +               .name = "/chosen",
> > +               .properties = {
> > +                       "stdout-path",
> > +                       "linux,stdout-path",
> > +                       NULL,
> > +               }
> > +       },
> > +       {
> > +               .name = "vga",
> > +               .properties = {
> > +                       "device_type=display",
> > +                       "assigned-addresses",
> > +                       "width",
> > +                       "height",
> > +                       "depth",
> > +                       "little-endian=",
> > +                       "linux,opened=",
> > +                       "linux,boot-display=",ss
> > +                       NULL,
> > +               }
> > +       },
> > +};
> 
> Hi Thiago,
> 
> As much as this solves problems for *me*, I suspect adding 'vga' here
> might be the subject of some discussion. Having /chosen whitelisted makes
> sense on it's own, but 'vga' and its properties are very specific without
> much explanation.
> 
> If everyone's happy to have it there, cool! If not, I have the majority
> of a patch that handles the original reason for these property updates
> separately in the kernel rather than from userspace. If needed I'll clean
> it up and we can handle it that way.

Ok, that's good to know. I'm fine with it either way. In any case, 'vga' in 
this patch also serves a good real-life example of a non-trivial binding 
outside of /chosen that we might want to whitelist in the future.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
