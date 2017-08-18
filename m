Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, SZ Lin
 <sz.lin@moxa.com>
Cc: Linuxppc-dev <linuxppc-dev-bounces+msuchanek=suse.de@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 paulus@samba.org, ashleydlai@gmail.com, peterhuewe@gmx.de,
 linuxppc-dev@lists.ozlabs.org, tpmdd@selhorst.ne
Subject: Re: [PATCH 5/5] Use __func__ instead of function name
In-Reply-To: <0e2d9ac4f5ee02e9df98610ed07eaec9@suse.de>
References: <20170729072433.13194-1-sz.lin@moxa.com>
 <20170729072433.13194-6-sz.lin@moxa.com>
 <0e2d9ac4f5ee02e9df98610ed07eaec9@suse.de>
Date: Fri, 18 Aug 2017 21:25:39 +1000
Message-ID: <87378pqfrg.fsf@concordia.ellerman.id.au>
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

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On 2017-07-29 09:24, SZ Lin wrote:
>> Fix following checkpatch.pl warning:
>> WARNING: Prefer using '"%s...", __func__' to using
>> the function's name, in a string
>>=20
>> Signed-off-by: SZ Lin <sz.lin@moxa.com>
>> ---
>>  drivers/char/tpm/tpm_ibmvtpm.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c=20
>> b/drivers/char/tpm/tpm_ibmvtpm.c
>> index e75a674b44ac..2d33acc43e25 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> @@ -151,7 +151,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip,
>> u8 *buf, size_t count)
>>  	rc =3D ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
>>  			      be64_to_cpu(word[1]));
>>  	if (rc !=3D H_SUCCESS) {
>> -		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=3D%d\n", rc);
>> +		dev_err(ibmvtpm->dev, "%s failed rc=3D%d\n", __func__, rc);
>
> Can function name contain a %?

Let's hope not.

$ git grep "%s.*__func__" | wc -l
16937

cheers
