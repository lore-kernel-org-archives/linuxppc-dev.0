Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB2C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 10:55:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0BF2086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 10:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0BF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FrDb2MW8zDr02
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 21:55:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FrBC01ZszDqSK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 21:53:06 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBDAnhkh006913
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 05:53:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pbnnnh760-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 05:53:04 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.ibm.com>;
 Thu, 13 Dec 2018 10:53:01 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Dec 2018 10:52:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBDAqwAr57016330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Dec 2018 10:52:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C41CFA4054;
 Thu, 13 Dec 2018 10:52:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BF4FA405F;
 Thu, 13 Dec 2018 10:52:58 +0000 (GMT)
Received: from localhost (unknown [9.79.182.93])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Dec 2018 10:52:58 +0000 (GMT)
Date: Thu, 13 Dec 2018 16:22:57 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v1 2/2] powerpc/pseries: Add debugfs interface to retrieve
 VPHN info
To: Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1544459267.git.naveen.n.rao@linux.ibm.com>
 <e308130fe45a8930743cec9aba83d4885ac8d30d.1544459267.git.naveen.n.rao__35218.1831411601$1544472513$gmane$org@linux.ibm.com>
In-Reply-To: <e308130fe45a8930743cec9aba83d4885ac8d30d.1544459267.git.naveen.n.rao__35218.
 1831411601$1544472513$gmane$org@linux.ibm.com>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 18121310-0028-0000-0000-00000329E707
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121310-0029-0000-0000-000023E630B5
Message-Id: <1544698314.ofwuo2zvuf.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-13_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130098
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

Naveen N. Rao wrote:
> Add debugfs interface to retrieve associativity information for lpar
> vcpus (debugfs/vphn/lpar) and the hypervisor cpus (debugfs/vphn/hyp).
> This information is useful to derive various metrics, including the vcpu
> dispatch statistics in a SPLPAR environment.

Any thoughts on this approach vs. adding a tracepoint?


Thanks,
Naveen

>=20
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 105 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>=20
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 6677a578f18d..f0b0e87016e6 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -40,6 +40,7 @@
>  #include <asm/setup.h>
>  #include <asm/vdso.h>
>  #include <asm/drmem.h>
> +#include <asm/debugfs.h>
> =20
>  static int numa_enabled =3D 1;
> =20
> @@ -1089,6 +1090,107 @@ static long hcall_vphn(unsigned long cpu, u64 fla=
gs, __be32 *associativity)
>  	return rc;
>  }
> =20
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t vphn_lpar_cpu_file_read(struct file *filp, char __user *b=
uf,
> +		size_t len, loff_t *pos)
> +{
> +	int cpu =3D (long)filp->private_data;
> +	__be32 associativity[VPHN_ASSOC_BUFSIZE] =3D {0};
> +	int hwcpu =3D get_hard_smp_processor_id(cpu);
> +	long int rc;
> +
> +	if (len !=3D sizeof(associativity))
> +		return -EINVAL;
> +
> +	rc =3D hcall_vphn(hwcpu, 1, associativity);
> +	if (rc)
> +		return -EFAULT;
> +
> +	rc =3D copy_to_user(buf, &associativity, sizeof(associativity));
> +	if (rc)
> +		return -EFAULT;
> +
> +	return sizeof(associativity);
> +}
> +
> +static ssize_t vphn_hyp_cpu_file_read(struct file *filp, char __user *bu=
f,
> +		size_t len, loff_t *pos)
> +{
> +	int cpu =3D (long)filp->private_data;
> +	__be32 associativity[VPHN_ASSOC_BUFSIZE] =3D {0};
> +	long int rc;
> +
> +	if (len !=3D sizeof(associativity))
> +		return -EINVAL;
> +
> +	rc =3D hcall_vphn(cpu, 2, associativity);
> +	if (rc)
> +		return -EFAULT;
> +
> +	rc =3D copy_to_user(buf, &associativity, sizeof(associativity));
> +	if (rc)
> +		return -EFAULT;
> +
> +	return sizeof(associativity);
> +}
> +
> +static const struct file_operations vphn_lpar_cpu_fops =3D {
> +	.open		=3D simple_open,
> +	.read		=3D vphn_lpar_cpu_file_read,
> +	.llseek		=3D no_llseek,
> +};
> +
> +static const struct file_operations vphn_hyp_cpu_fops =3D {
> +	.open		=3D simple_open,
> +	.read		=3D vphn_hyp_cpu_file_read,
> +	.llseek		=3D no_llseek,
> +};
> +
> +static int debug_init_vphn_entries(void)
> +{
> +	struct dentry *vphn_dir, *vphn_lpar_dir, *vphn_hyp_dir;
> +	struct dentry *vphn_lpar_cpu_file, *vphn_hyp_cpu_file;
> +	long cpu;
> +	char name[10];
> +
> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
> +		return 0;
> +
> +	vphn_dir =3D debugfs_create_dir("vphn", powerpc_debugfs_root);
> +	if (!vphn_dir) {
> +		pr_warn("%s: can't create vphn debugfs root dir\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	vphn_lpar_dir =3D debugfs_create_dir("lpar", vphn_dir);
> +	vphn_hyp_dir =3D debugfs_create_dir("hyp", vphn_dir);
> +	if (!vphn_lpar_dir || !vphn_hyp_dir) {
> +		pr_warn("%s: can't create vphn dir\n", __func__);
> +		goto err_remove_dir;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		sprintf(name, "cpu-%ld", cpu);
> +		vphn_lpar_cpu_file =3D debugfs_create_file(name, 0400,
> +				vphn_lpar_dir, (void *)cpu, &vphn_lpar_cpu_fops);
> +		vphn_hyp_cpu_file =3D debugfs_create_file(name, 0400,
> +				vphn_hyp_dir, (void *)cpu, &vphn_hyp_cpu_fops);
> +		if (!vphn_lpar_cpu_file || !vphn_hyp_cpu_file) {
> +			pr_warn("%s: can't create vphn cpu file\n", __func__);
> +			goto err_remove_dir;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_remove_dir:
> +	debugfs_remove_recursive(vphn_dir);
> +	return -ENOMEM;
> +}
> +#else
> +static int debug_init_vphn_entries(void) { return 0; }
> +#endif /* CONFIG_DEBUG_FS */
> +
>  /*
>   * Change polling interval for associativity changes.
>   */
> @@ -1619,6 +1721,9 @@ static int topology_update_init(void)
>  	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops)=
)
>  		return -ENOMEM;
> =20
> +	if (!debug_init_vphn_entries())
> +		return -ENOMEM;
> +
>  	topology_inited =3D 1;
>  	return 0;
>  }
> --=20
> 2.19.2
>=20
>=20
>=20
=

