Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBCDC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3A4206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3A4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438dZJ2HYGzDqZy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 10:37:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438dWy4CDJzDqXY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 10:35:25 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB4NUI5V108695
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2018 18:35:22 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p62hp9udj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 18:35:22 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Tue, 4 Dec 2018 23:35:22 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 4 Dec 2018 23:35:17 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB4NZGdl24314094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Dec 2018 23:35:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD520C6055;
 Tue,  4 Dec 2018 23:35:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BF6CC605A;
 Tue,  4 Dec 2018 23:35:12 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.142.32])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue,  4 Dec 2018 23:35:12 +0000 (GMT)
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
 <alpine.LRH.2.21.1812050855270.22148@namei.org>
User-agent: mu4e 1.0; emacs 26.1
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v8 00/14] Appended signatures support for IMA appraisal
In-reply-to: <alpine.LRH.2.21.1812050855270.22148@namei.org>
Date: Tue, 04 Dec 2018 21:35:07 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18120423-0016-0000-0000-0000095F714E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010172; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127061; UDB=6.00585382; IPR=6.00907195; 
 MB=3.00024448; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-04 23:35:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120423-0017-0000-0000-0000414B0F40
Message-Id: <87k1ko50ic.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-04_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040202
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-doc@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>,
 "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hello James,

Thanks for you interest in these patches.

James Morris <jmorris@namei.org> writes:

> On Fri, 16 Nov 2018, Thiago Jung Bauermann wrote:
>
>> On the OpenPOWER platform, secure boot and trusted boot are being
>> implemented using IMA for taking measurements and verifying signatures.
>> Since the kernel image on Power servers is an ELF binary, kernels are
>> signed using the scripts/sign-file tool and thus use the same signature
>> format as signed kernel modules.
>>
>> This patch series adds support in IMA for verifying those signatures.
>
> Are you saying you use IMA to verify kernels during boot?  From a Linux
> bootloader?

Yes to both. OpenPOWER machines have embedded in their firmware a Linux
kernel and initramfs to use as bootloader, using Petitboot. kexec is
used to load the OS and boot it.

>> It adds flexibility to OpenPOWER secure boot, because it allows it to boot
>> kernels with the signature appended to them as well as kernels where the
>> signature is stored in the IMA extended attribute.
>
> Just to clarify, with these patches, IMA will be able to verify the
> native form of signed kernel modules?

That wasn't my use case to develop the patches, but I just tested and it
works.

I just had to make a slight modification: there's a whitelist of IMA
hooks that are allowed to use the module signature format (in the
ima_hook_supports_modsig function), and I had to add MODULE_CHECK to it.
The next version of the patches will have this change.

The only difference is that IMA looks for a valid key in the IMA
keyring, while the CONFIG_MODULE_SIG code looks for the module signing
key in the builtin and secondary trusted keyrings.

> i.e. without xattrs at all, and
> this will work with existing signed modules?

No xattrs at all, and yes.

--
Thiago Jung Bauermann
IBM Linux Technology Center

