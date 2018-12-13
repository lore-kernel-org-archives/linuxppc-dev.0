Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E6DC67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 02:13:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E0C20851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 02:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E0C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Fcft64mczDqWh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 13:13:42 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fcbk2zL5zDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 13:10:57 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBD24GSc137407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 21:10:55 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pbbt7e61x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 21:10:54 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 13 Dec 2018 02:10:54 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Dec 2018 02:10:49 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBD2Aljr13500514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Dec 2018 02:10:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4430BC605A;
 Thu, 13 Dec 2018 02:10:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E531C6069;
 Thu, 13 Dec 2018 02:10:32 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.227.60])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 13 Dec 2018 02:10:32 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Subject: [PATCH v9 00/14] Appended signatures support for IMA appraisal
Date: Thu, 13 Dec 2018 00:08:53 -0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 18121302-0004-0000-0000-000014C1686A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010217; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130951; UDB=6.00587714; IPR=6.00911084; 
 MB=3.00024674; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 02:10:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121302-0005-0000-0000-000089D51DF7
Message-Id: <20181213020907.13601-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-12_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130017
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
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

This version is basically about tidying up the code to make it clearer. Most
of the changes are in patches 11 and 14.

There are two functional changes: one is modifying the list of hooks allowed
to use modsig to allow verifying signed modules and disallow verifying
firmware, and the other is to use the platform keyring as fallback for kexec
kernel verification.

The changelog below has the details. The patches apply on today's
linux-integrity/next-integrity.

Original cover letter:

On the OpenPOWER platform, secure boot and trusted boot are being
implemented using IMA for taking measurements and verifying signatures.
Since the kernel image on Power servers is an ELF binary, kernels are
signed using the scripts/sign-file tool and thus use the same signature
format as signed kernel modules.

This patch series adds support in IMA for verifying those signatures.
It adds flexibility to OpenPOWER secure boot, because it allows it to boot
kernels with the signature appended to them as well as kernels where the
signature is stored in the IMA extended attribute.

Changes since v8:
- Patch "MODSIGN: Export module signature definitions"
  - Renamed validate_module_sig() to mod_check_sig(). (Suggested by
    Mimi Zohar).

- Patch "integrity: Introduce struct evm_xattr"
  - Added comment mentioning that the evm_xattr usage is limited to HMAC
    before the structure definition. (Suggested by Mimi Zohar)

- Patch "ima: Add modsig appraise_type option for module-style appended
         signatures"
  - Added MODULE_CHECK to whitelist of hooks allowed to use modsig, and
    removed FIRMWARE_CHECK. (Suggested by Mimi Zohar and James Morris)

- Patch "ima: Implement support for module-style appended signatures"
  - Moved call to ima_modsig_verify() from ima_appraise_measurement() to
    integrity_digsig_verify(). (Suggested by Mimi Zohar)
  - Renamed ima_read_modsig() to ima_read_collect_modsig() and made it force
    PKCS7 code to calculate the file hash. (Suggested by Mimi Zohar)
  - Build sign-file tool if IMA_APPRAISE_MODSIG is enabled.
  - Check whether the signing key is in the platform keyring as a fallback
    for the KEXEC_KERNEL hook. (Suggested by Mimi Zohar)

- Patch "ima: Store the measurement again when appraising a modsig"
  - In process_measurement(), when a new measurement needs to be stored
    re-add IMA_MEASURE flag when the modsig is read rather than changing the
    if condition when calling ima_store_measurement(). (Suggested by Mimi
    Zohar)
  - Check whether ima_template has "sig" and "d-sig" fields at
    initialization rather than at the first time the check is needed.
    (suggested by Mimi Zohar)

Changes since v7:
- Patch "MODSIGN: Export module signature definitions"
  - Added module name parameter to validate_module_sig() so that it can be
    shown in error messages.

- Patch "integrity: Introduce struct evm_xattr"
  - Dropped use of struct evm_xattr in evm_update_evmxattr() and
    evm_verify_hmac(). It's not needed there anymore because of changes
    to support portable EVM signatures.

Changes since v6:

- Patch "PKCS#7: Introduce pkcs7_get_message_sig() and verify_pkcs7_message_sig()"
  - Retitled to "PKCS#7: Refactor verify_pkcs7_signature() and
    add pkcs7_get_message_sig()"
  - Reworded description to clarify why the refactoring is needed.
    The code is unchanged. (Suggested by Mimi Zohar)
  - Added Mimi Zohar's Reviewed-by.

- Patch "PKCS#7: Introduce pkcs7_get_digest()"
  - Added Mimi Zohar's Reviewed-by.

- Patch "integrity: Introduce integrity_keyring_from_id"
  - Added Mimi Zohar's Signed-off-by.

- Patch "integrity: Introduce asymmetric_sig_has_known_key()"
  - Added Mimi Zohar's Signed-off-by.

- Patch "integrity: Select CONFIG_KEYS instead of depending on it"
  - Added Mimi Zohar's Signed-off-by.

- Patch "ima: Introduce is_ima_sig()"
  - Renamed function to is_signed() (suggested by Mimi Zohar).

- Patch "ima: Add functions to read and verify a modsig signature"
  - Changed stubs for the !CONFIG_IMA_APPRAISE_MODSIG to return -EOPNOTSUPP
    instead of -ENOTSUPP, since the latter isn't defined in uapi headers.
  - Moved functions to the patches which use them and dropped this patch
    (suggested by Mimi Zohar).

- Patch "ima: Implement support for module-style appended signatures"
  - Prevent reading and writing of IMA_MODSIG xattr in ima_read_xattr()
    and ima_inode_setxattr().
  - Simplify code in process_measurement() which decides whether to try
    reading a modsig (suggested by Mimi Zohar).
  - Moved some functions from patch "ima: Add functions to read and verify
    a modsig signature" into this patch.

- Patch "ima: Add new "d-sig" template field"
  - New patch containing code from patch "ima: Write modsig to the measurement list"
    (Suggested by Mimi Zohar).

- Patch "ima: Write modsig to the measurement list"
  - Moved some functions from patch "ima: Add functions to read and verify
    a modsig signature" into this patch.
  - Moved code related to d-sig support to new patch.

- Patch "ima: Store the measurement again when appraising a modsig"
  - New patch.

Thiago Jung Bauermann (14):
  MODSIGN: Export module signature definitions
  PKCS#7: Refactor verify_pkcs7_signature() and add
    pkcs7_get_message_sig()
  PKCS#7: Introduce pkcs7_get_digest()
  integrity: Introduce struct evm_xattr
  integrity: Introduce integrity_keyring_from_id()
  integrity: Introduce asymmetric_sig_has_known_key()
  integrity: Select CONFIG_KEYS instead of depending on it
  ima: Introduce is_signed()
  ima: Export func_tokens
  ima: Add modsig appraise_type option for module-style appended
    signatures
  ima: Implement support for module-style appended signatures
  ima: Add new "d-sig" template field
  ima: Write modsig to the measurement list
  ima: Store the measurement again when appraising a modsig

 Documentation/ABI/testing/ima_policy      |   6 +-
 Documentation/security/IMA-templates.rst  |   5 +
 certs/system_keyring.c                    |  61 ++++--
 crypto/asymmetric_keys/pkcs7_parser.c     |  16 ++
 crypto/asymmetric_keys/pkcs7_verify.c     |  27 +++
 include/crypto/pkcs7.h                    |   5 +
 include/linux/module.h                    |   3 -
 include/linux/module_signature.h          |  47 +++++
 include/linux/verification.h              |  10 +
 init/Kconfig                              |   6 +-
 kernel/Makefile                           |   2 +-
 kernel/module.c                           |   1 +
 kernel/module_signing.c                   |  82 ++++----
 scripts/Makefile                          |   4 +-
 security/integrity/Kconfig                |   2 +-
 security/integrity/digsig.c               |  31 ++-
 security/integrity/digsig_asymmetric.c    |  44 +++--
 security/integrity/evm/evm_main.c         |   8 +-
 security/integrity/ima/Kconfig            |  13 ++
 security/integrity/ima/Makefile           |   1 +
 security/integrity/ima/ima.h              |  62 ++++++
 security/integrity/ima/ima_api.c          |   9 +-
 security/integrity/ima/ima_appraise.c     |  82 +++++++-
 security/integrity/ima/ima_main.c         |  29 ++-
 security/integrity/ima/ima_modsig.c       | 229 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |  81 ++++++--
 security/integrity/ima/ima_template.c     |  28 ++-
 security/integrity/ima/ima_template_lib.c |  49 ++++-
 security/integrity/ima/ima_template_lib.h |   2 +
 security/integrity/integrity.h            |  40 +++-
 30 files changed, 861 insertions(+), 124 deletions(-)
 create mode 100644 include/linux/module_signature.h
 create mode 100644 security/integrity/ima/ima_modsig.c

