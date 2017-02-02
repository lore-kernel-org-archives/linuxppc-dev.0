Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDcNv1FpZzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 21:55:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vicky <honclo@linux.vnet.ibm.com>, Ashley Lai <ashleydlai@gmail.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "Michal Such\?\?nek" <msuchanek@suse.de>,
 Nayna Jain <nayna@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Peter Huewe <peterhuewe@gmx.de>,
 Marcel Selhorst <tpmdd@selhorst.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 tpmdd-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: ibmvtpm byteswapping inconsistency
In-Reply-To: <F14AC3E9-E04F-4EF0-9C7E-999D481EA577@linux.vnet.ibm.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <20170126220536.GB31937@obsidianresearch.com>
 <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
 <F14AC3E9-E04F-4EF0-9C7E-999D481EA577@linux.vnet.ibm.com>
Date: Thu, 02 Feb 2017 21:55:57 +1100
Message-ID: <87k298c14y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vicky <honclo@linux.vnet.ibm.com> writes:

>> On Jan 26, 2017, at 5:58 PM, Ashley Lai <ashleydlai@gmail.com> wrote:
>>=20
>> Adding Vicky from IBM.
>>=20
>>=20
>> On 01/26/2017 04:05 PM, Jason Gunthorpe wrote:
>>> On Thu, Jan 26, 2017 at 09:22:48PM +0100, Michal Such??nek wrote:
>>>=20
>>>> This is repeated a few times in the driver so I added memset to quiet
>>>> gcc and make behavior deterministic in case the unused fields get some
>>>> meaning in the future.
>>> Yep, reserved certainly needs to be zeroed.. Can you send a patch?
>>> memset is overkill...
>>>=20
>>>> However, in tpm_ibmvtpm_send the structure is initialized as
>>>>=20
>>>> 	struct ibmvtpm_crq crq;
>>>>         __be64 *word =3D (__be64 *)&crq;
>>>> ...
>>>>         crq.valid =3D (u8)IBMVTPM_VALID_CMD;
>>>>         crq.msg =3D (u8)VTPM_TPM_COMMAND;
>>>>         crq.len =3D cpu_to_be16(count);
>>>>         crq.data =3D cpu_to_be32(ibmvtpm->rtce_dma_handle);
>>>>=20
>>>> and submitted with
>>>>=20
>>>> 	rc =3D ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
>>>>                               be64_to_cpu(word[1]));
>>>> meaning it is swapped twice.
>>> No idea, Nayna may know.
>>>=20
>>> My guess is that '__be64 *word' should be 'u64 *word'...
>>>=20
>>> Jason
>>=20
>
> I don=E2=80=99t think we want =E2=80=98word' to be changed back to be of =
type =E2=80=98u64=E2=80=99.   Please see commit 62dfd912ab3b5405b6fe72d0135=
c37e9648071f1

The type of word is basically irrelevant. Unless you're running sparse
and actually checking the errors, which it seems you're not doing:

  drivers/char/tpm/tpm_ibmvtpm.c:90:30: warning: cast removes address space=
 of expression
  drivers/char/tpm/tpm_ibmvtpm.c:91:23: warning: incorrect type in argument=
 1 (different address spaces)
  drivers/char/tpm/tpm_ibmvtpm.c:91:23:    expected void *<noident>
  drivers/char/tpm/tpm_ibmvtpm.c:91:23:    got void [noderef] <asn:2>*rtce_=
buf
  drivers/char/tpm/tpm_ibmvtpm.c:136:17: warning: cast removes address spac=
e of expression
  drivers/char/tpm/tpm_ibmvtpm.c:188:46: warning: incorrect type in argumen=
t 2 (different base types)
  drivers/char/tpm/tpm_ibmvtpm.c:188:46:    expected unsigned long long [un=
signed] [usertype] w1
  drivers/char/tpm/tpm_ibmvtpm.c:188:46:    got restricted __be64 [usertype=
] <noident>
  drivers/char/tpm/tpm_ibmvtpm.c:189:31: warning: incorrect type in argumen=
t 3 (different base types)
  drivers/char/tpm/tpm_ibmvtpm.c:189:31:    expected unsigned long long [un=
signed] [usertype] w2
  drivers/char/tpm/tpm_ibmvtpm.c:189:31:    got restricted __be64 [usertype=
] <noident>
  drivers/char/tpm/tpm_ibmvtpm.c:215:46: warning: incorrect type in argumen=
t 2 (different base types)
  drivers/char/tpm/tpm_ibmvtpm.c:215:46:    expected unsigned long long [un=
signed] [usertype] w1
  drivers/char/tpm/tpm_ibmvtpm.c:215:46:    got restricted __be64 [usertype=
] <noident>
  drivers/char/tpm/tpm_ibmvtpm.c:216:31: warning: incorrect type in argumen=
t 3 (different base types)
  drivers/char/tpm/tpm_ibmvtpm.c:216:31:    expected unsigned long long [un=
signed] [usertype] w2
  drivers/char/tpm/tpm_ibmvtpm.c:216:31:    got restricted __be64 [usertype=
] <noident>
  drivers/char/tpm/tpm_ibmvtpm.c:294:30: warning: incorrect type in argumen=
t 1 (different address spaces)
  drivers/char/tpm/tpm_ibmvtpm.c:294:30:    expected void const *<noident>
  drivers/char/tpm/tpm_ibmvtpm.c:294:30:    got void [noderef] <asn:2>*rtce=
_buf
  drivers/char/tpm/tpm_ibmvtpm.c:342:46: warning: incorrect type in argumen=
t 2 (different base types)
  drivers/char/tpm/tpm_ibmvtpm.c:342:46:    expected unsigned long long [un=
signed] [usertype] w1
  drivers/char/tpm/tpm_ibmvtpm.c:342:46:    got restricted __be64 [usertype=
] <noident>
  drivers/char/tpm/tpm_ibmvtpm.c:343:31: warning: incorrect type in argumen=
t 3 (different base types)
  drivers/char/tpm/tpm_ibmvtpm.c:343:31:    expected unsigned long long [un=
signed] [usertype] w2
  drivers/char/tpm/tpm_ibmvtpm.c:343:31:    got restricted __be64 [usertype=
] <noident>
  drivers/char/tpm/tpm_ibmvtpm.c:494:43: warning: incorrect type in assignm=
ent (different address spaces)
  drivers/char/tpm/tpm_ibmvtpm.c:494:43:    expected void [noderef] <asn:2>=
*rtce_buf
  drivers/char/tpm/tpm_ibmvtpm.c:494:43:    got void *
  drivers/char/tpm/tpm_ibmvtpm.c:501:52: warning: incorrect type in argumen=
t 2 (different address spaces)
  drivers/char/tpm/tpm_ibmvtpm.c:501:52:    expected void *ptr
  drivers/char/tpm/tpm_ibmvtpm.c:501:52:    got void [noderef] <asn:2>*rtce=
_buf
  drivers/char/tpm/tpm_ibmvtpm.c:507:46: warning: incorrect type in argumen=
t 1 (different address spaces)
  drivers/char/tpm/tpm_ibmvtpm.c:507:46:    expected void const *<noident>
  drivers/char/tpm/tpm_ibmvtpm.c:507:46:    got void [noderef] <asn:2>*rtce=
_buf


What matters is how you actually do the byte swaps.

cheers
