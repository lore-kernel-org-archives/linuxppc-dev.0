Return-Path: <maynardj@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 94B59B7227
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 04:35:23 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maynardj@us.ibm.com>;
 Thu, 17 Nov 2011 12:35:17 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAHHUsnr302900
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 12:30:57 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAHHUoBf028208
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 12:30:50 -0500
Message-ID: <4EC544C6.3050502@us.ibm.com>
Date: Thu, 17 Nov 2011 11:30:46 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: oprofile callgraph support missing for common cpus
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
In-Reply-To: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
 oprofile-list@lists.sourceforge.net
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2011 2:38 AM, Joakim Tjernlund wrote:
>
> arch/powerpc/oprofile/common.c has this init code:
>
> int __init oprofile_arch_init(struct oprofile_operations *ops)
> {
> 		 if (!cur_cpu_spec->oprofile_cpu_type)
> 		 		 return -ENODEV;
>
> 		 if (firmware_has_feature(FW_FEATURE_ISERIES))
> 		 		 return -ENODEV;
>
> 		 switch (cur_cpu_spec->oprofile_type) {
> #ifdef CONFIG_PPC_BOOK3S_64
> #ifdef CONFIG_OPROFILE_CELL
> 		 		 case PPC_OPROFILE_CELL:
> 		 		 		 if (firmware_has_feature(FW_FEATURE_LPAR))
> 		 		 		 		 return -ENODEV;
> 		 		 		 model =&op_model_cell;
> 		 		 		 ops->sync_start = model->sync_start;
> 		 		 		 ops->sync_stop = model->sync_stop;
> 		 		 		 break;
> #endif
> 		 		 case PPC_OPROFILE_RS64:
> 		 		 		 model =&op_model_rs64;
> 		 		 		 break;
> 		 		 case PPC_OPROFILE_POWER4:
> 		 		 		 model =&op_model_power4;
> 		 		 		 break;
> 		 		 case PPC_OPROFILE_PA6T:
> 		 		 		 model =&op_model_pa6t;
> 		 		 		 break;
> #endif
> #ifdef CONFIG_6xx
> 		 		 case PPC_OPROFILE_G4:
> 		 		 		 model =&op_model_7450;
> 		 		 		 break;
> #endif
> #if defined(CONFIG_FSL_EMB_PERFMON)
> 		 		 case PPC_OPROFILE_FSL_EMB:
> 		 		 		 model =&op_model_fsl_emb;
> 		 		 		 break;
> #endif
> 		 		 default:
> 		 		 		 return -ENODEV;
> 		 }
>
> 		 model->num_counters = cur_cpu_spec->num_pmcs;
>
> 		 ops->cpu_type = cur_cpu_spec->oprofile_cpu_type;
> 		 ops->create_files = op_powerpc_create_files;
> 		 ops->setup = op_powerpc_setup;
> 		 ops->shutdown = op_powerpc_shutdown;
> 		 ops->start = op_powerpc_start;
> 		 ops->stop = op_powerpc_stop;
> 		 ops->backtrace = op_powerpc_backtrace;
> }
>
> Notice the first
> 		 if (!cur_cpu_spec->oprofile_cpu_type)
> 		 		 return -ENODEV;
>
> 		 if (firmware_has_feature(FW_FEATURE_ISERIES))
> 		 		 return -ENODEV;
> For my e300c2 cpu both if's are false and I don't get support for callgraph/backtrace
> support. Moving the ops->backtrace = op_powerpc_backtrace; to the top
> enables backtrace for me.
What kernel version are you using?  Actually, looking at a 3.0.3 tree I happen 
to have available, I see oprofile h/w event support (in 
arch/powerpc/kernel/cputable.c) for e300c3 and e300c4, but not the other e300 
flavors.  I've added Andy Flemming from Freescale to cc.  Maybe he knows why 
e300c2 isn't supported.

-Maynard

>
> This function needs fixing so its not all or nothing but I cannot make out
> what is what so please, could someone look at this?
>
> I am somewhat behind mainline so I will just use my hack for now.
>
>   Jocke
>
>
> ------------------------------------------------------------------------------
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
>
