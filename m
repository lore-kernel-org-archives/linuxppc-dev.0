Return-Path: <msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 18 Aug 2017 10:03:17 +0200
From: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
To: SZ Lin <sz.lin@moxa.com>
Cc: ashleydlai@gmail.com, linux-kernel@vger.kernel.org,
 jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com,
 tpmdd-devel@lists.sourceforge.net, paulus@samba.org, peterhuewe@gmx.de,
 linuxppc-dev@lists.ozlabs.org, tpmdd@selhorst.ne, Linuxppc-dev
 <linuxppc-dev-bounces+msuchanek=suse.de@lists.ozlabs.org>
Subject: Re: [PATCH 5/5] Use __func__ instead of function name
In-Reply-To: <20170729072433.13194-6-sz.lin@moxa.com>
References: <20170729072433.13194-1-sz.lin@moxa.com>
 <20170729072433.13194-6-sz.lin@moxa.com>
Message-ID: <0e2d9ac4f5ee02e9df98610ed07eaec9@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-07-29 09:24, SZ Lin wrote:
> Fix following checkpatch.pl warning:
> WARNING: Prefer using '"%s...", __func__' to using
> the function's name, in a string
> 
> Signed-off-by: SZ Lin <sz.lin@moxa.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c 
> b/drivers/char/tpm/tpm_ibmvtpm.c
> index e75a674b44ac..2d33acc43e25 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -151,7 +151,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip,
> u8 *buf, size_t count)
>  	rc = ibmvtpm_send_crq(ibmvtpm->vdev, be64_to_cpu(word[0]),
>  			      be64_to_cpu(word[1]));
>  	if (rc != H_SUCCESS) {
> -		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
> +		dev_err(ibmvtpm->dev, "%s failed rc=%d\n", __func__, rc);

Can function name contain a %?

I would prefer dev_err(ibmvtpm->dev, __func__ " failed rc=%d\n", rc);

It's not what checkpatch advises in the above message, though.

Presumably with many messages from the same function using %s would
save space but that is not the usual case.

Thanks

Michal
