Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 491E7B71B9
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 19:38:18 +1100 (EST)
Subject: oprofile callgraph support missing for common cpus
To: linuxppc-dev@ozlabs.org
Message-ID: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 17 Nov 2011 09:38:12 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


arch/powerpc/oprofile/common.c has this init code:

int __init oprofile_arch_init(struct oprofile_operations *ops)
{
		 if (!cur_cpu_spec->oprofile_cpu_type)
		 		 return -ENODEV;

		 if (firmware_has_feature(FW_FEATURE_ISERIES))
		 		 return -ENODEV;

		 switch (cur_cpu_spec->oprofile_type) {
#ifdef CONFIG_PPC_BOOK3S_64
#ifdef CONFIG_OPROFILE_CELL
		 		 case PPC_OPROFILE_CELL:
		 		 		 if (firmware_has_feature(FW_FEATURE_LPAR))
		 		 		 		 return -ENODEV;
		 		 		 model = &op_model_cell;
		 		 		 ops->sync_start = model->sync_start;
		 		 		 ops->sync_stop = model->sync_stop;
		 		 		 break;
#endif
		 		 case PPC_OPROFILE_RS64:
		 		 		 model = &op_model_rs64;
		 		 		 break;
		 		 case PPC_OPROFILE_POWER4:
		 		 		 model = &op_model_power4;
		 		 		 break;
		 		 case PPC_OPROFILE_PA6T:
		 		 		 model = &op_model_pa6t;
		 		 		 break;
#endif
#ifdef CONFIG_6xx
		 		 case PPC_OPROFILE_G4:
		 		 		 model = &op_model_7450;
		 		 		 break;
#endif
#if defined(CONFIG_FSL_EMB_PERFMON)
		 		 case PPC_OPROFILE_FSL_EMB:
		 		 		 model = &op_model_fsl_emb;
		 		 		 break;
#endif
		 		 default:
		 		 		 return -ENODEV;
		 }

		 model->num_counters = cur_cpu_spec->num_pmcs;

		 ops->cpu_type = cur_cpu_spec->oprofile_cpu_type;
		 ops->create_files = op_powerpc_create_files;
		 ops->setup = op_powerpc_setup;
		 ops->shutdown = op_powerpc_shutdown;
		 ops->start = op_powerpc_start;
		 ops->stop = op_powerpc_stop;
		 ops->backtrace = op_powerpc_backtrace;
}

Notice the first
		 if (!cur_cpu_spec->oprofile_cpu_type)
		 		 return -ENODEV;

		 if (firmware_has_feature(FW_FEATURE_ISERIES))
		 		 return -ENODEV;
For my e300c2 cpu both if's are false and I don't get support for callgraph/backtrace
support. Moving the ops->backtrace = op_powerpc_backtrace; to the top
enables backtrace for me.

This function needs fixing so its not all or nothing but I cannot make out
what is what so please, could someone look at this?

I am somewhat behind mainline so I will just use my hack for now.

 Jocke
