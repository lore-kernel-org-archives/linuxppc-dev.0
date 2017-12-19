Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0066.hostedemail.com
 [216.40.44.66])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Rnl61qCzF078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 05:51:23 +1100 (AEDT)
Message-ID: <1513709474.1234.66.camel@perches.com>
Subject: Re: [-next PATCH 4/4] treewide: Use DEVICE_ATTR_WO
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Falcon
 <tlfalcon@linux.vnet.ibm.com>, John Allen <jallen@linux.vnet.ibm.com>,
 Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
 linux-wimax@intel.com, James Smart <james.smart@broadcom.com>,  Dick
 Kennedy <dick.kennedy@broadcom.com>, Zhang Rui <rui.zhang@intel.com>,
 Eduardo Valentin <edubezval@gmail.com>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,  "James E.J.
 Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-input@vger.kernel.org,
 netdev@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 linux-scsi@vger.kernel.org,  linux-pm@vger.kernel.org
Date: Tue, 19 Dec 2017 10:51:14 -0800
In-Reply-To: <20171219184441.ixxh757tl44qvk5l@pd.tnic>
References: <cover.1513706701.git.joe@perches.com>
 <fa30f1ad73f76dafff816df40cacffe613aa2f48.1513706702.git.joe@perches.com>
 <20171219184441.ixxh757tl44qvk5l@pd.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-19 at 19:44 +0100, Borislav Petkov wrote:
> On Tue, Dec 19, 2017 at 10:15:09AM -0800, Joe Perches wrote:
> > Convert DEVICE_ATTR uses to DEVICE_ATTR_WO where possible.
> > 
> > Done with perl script:
> > 
> > $ git grep -w --name-only DEVICE_ATTR | \
> >   xargs perl -i -e 'local $/; while (<>) { s/\bDEVICE_ATTR\s*\(\s*(\w+)\s*,\s*\(?(?:\s*S_IWUSR\s*|\s*0200\s*)\)?\s*,\s*NULL\s*,\s*\s_store\s*\)/DEVICE_ATTR_WO(\1)/g; print;}'
[]
> > diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
[]
> > @@ -560,7 +560,7 @@ static ssize_t pf_show(struct device *dev,
> >  	return sprintf(buf, "0x%x\n", uci->cpu_sig.pf);
> >  }
> >  
> > -static DEVICE_ATTR(reload, 0200, NULL, reload_store);
> > +static DEVICE_ATTR_WO(reload);
> >  static DEVICE_ATTR(version, 0400, version_show, NULL);
> >  static DEVICE_ATTR(processor_flags, 0400, pf_show, NULL);
> >  
> 
> # cat /sys/devices/system/cpu/microcode/reload
> cat: /sys/devices/system/cpu/microcode/reload: Permission denied

Not different behavior.  It was and remains write only.

> The reason for the code churn being?

Consistency for easier grep by use-type.
