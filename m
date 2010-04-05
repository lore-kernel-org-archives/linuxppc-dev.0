Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id A7B79B7C06
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 09:48:10 +1000 (EST)
Received: by gxk2 with SMTP id 2so2979714gxk.3
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Apr 2010 16:48:08 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100405230301.GF32401@fluff.org.uk>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180649.4824.10368.stgit@angua>
	<20100405230301.GF32401@fluff.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Apr 2010 17:47:48 -0600
Message-ID: <q2tfa686aa41004051647p4c8182d0h807583d09714761a@mail.gmail.com>
Subject: Re: [PATCH 33/37] sound/soc: use .dev.of_node instead of .node in
	struct of_device
To: Ben Dooks <ben-linux@fluff.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	broonie@opensource.wolfsonmicro.com, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	gregkh@suse.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jeremy.kerr@canonical.com,
	linuxppc-dev@ozlabs.org, James.Bottomley@suse.de,
	linux-i2c@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	sparclinux@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, jgarzik@pobox.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben, thanks for the comment.  Reply below...

On Mon, Apr 5, 2010 at 5:03 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, Mar 11, 2010 at 11:06:50AM -0700, Grant Likely wrote:
>> .node is being removed
[...]
>> --- a/sound/soc/fsl/mpc8610_hpcd.c
>> +++ b/sound/soc/fsl/mpc8610_hpcd.c
>> @@ -202,7 +202,7 @@ static struct snd_soc_ops mpc8610_hpcd_ops =3D {
>> =A0static int mpc8610_hpcd_probe(struct of_device *ofdev,
>> =A0 =A0 =A0 const struct of_device_id *match)
>> =A0{
>> - =A0 =A0 struct device_node *np =3D ofdev->node;
>> + =A0 =A0 struct device_node *np =3D ofdev->dev.of_node;
>> =A0 =A0 =A0 struct device_node *codec_np =3D NULL;
>> =A0 =A0 =A0 struct device_node *guts_np =3D NULL;
>> =A0 =A0 =A0 struct device_node *dma_np =3D NULL;
>
> This looks like one case where an inline function would have been a
> help.

In what regard (how would you like it to look)?  The node pointer
location is very unlikely to move again, and I prefer the clarity of
direct dereferencing.

g.
