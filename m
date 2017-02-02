Return-Path: <honclo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDRl26KYzzDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:26:06 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v124OZ6H042165
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 23:26:04 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28bndvy6v7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 23:26:03 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <honclo@linux.vnet.ibm.com>;
 Thu, 2 Feb 2017 14:26:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C17563578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 15:25:59 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v124PpAb20709578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:25:59 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v124PQoT015716
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 15:25:27 +1100
In-Reply-To: <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
Subject: Re: ibmvtpm byteswapping inconsistency
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Michal Such??nek <msuchanek@suse.de>,
 Nayna Jain <nayna@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Date: Wed, 1 Feb 2017 23:24:59 -0500
To: Ashley Lai <ashleydlai@gmail.com>
From: Vicky <honclo@linux.vnet.ibm.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <20170126220536.GB31937@obsidianresearch.com>
 <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
Content-Type: text/html; charset=windows-1252
Message-Id: <DB6ECC32-23B4-4955-9B0E-7D658F7A5707@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body dir=3D"auto" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br><blockquote type=3D"cite">On Jan 26, 2017, at =
5:58 PM, Ashley Lai &lt;ashleydlai@gmail.com&gt; wrote:<br><br>Adding =
Vicky from IBM.<br><br><br>On 01/26/2017 04:05 PM, Jason Gunthorpe =
wrote:<br><blockquote type=3D"cite">On Thu, Jan 26, 2017 at 09:22:48PM =
+0100, Michal Such??nek wrote:<br><br><blockquote type=3D"cite">This is =
repeated a few times in the driver so I added memset to quiet<br>gcc and =
make behavior deterministic in case the unused fields get =
some<br>meaning in the future.<br></blockquote>Yep, reserved certainly =
needs to be zeroed.. Can you send a patch?<br>memset is =
overkill...<br><br><blockquote type=3D"cite">However, in =
tpm_ibmvtpm_send the structure is initialized as<br><br><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>struct =
ibmvtpm_crq crq;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;__be64 =
*word =3D (__be64 *)&amp;crq;<br>...<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;crq.valid =3D =
(u8)IBMVTPM_VALID_CMD;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;crq.msg =3D =
(u8)VTPM_TPM_COMMAND;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;crq.len =3D =
cpu_to_be16(count);<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;crq.data =3D =
cpu_to_be32(ibmvtpm-&gt;rtce_dma_handle);<br><br>and submitted =
with<br><br><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>rc =3D ibmvtpm_send_crq(ibmvtpm-&gt;vdev, =
be64_to_cpu(word[0]),<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;be64_to_cpu(word[1]));<br>meaning it is =
swapped twice.<br></blockquote>No idea, Nayna may know.<br><br>My guess =
is that '__be64 *word' should be 'u64 =
*word'...<br><br>Jason<br></blockquote><br></blockquote><br><br>Please =
refer to commit =
62dfd912ab3b5405b6fe72d0135c37e9648071f1<br><br><br>Vicky<br></body></html=
>=
