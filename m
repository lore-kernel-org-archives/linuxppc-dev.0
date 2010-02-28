Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 034E6B7D5D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 01:47:54 +1100 (EST)
Received: by gwj20 with SMTP id 20so825540gwj.15
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 06:47:53 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B8A2CD7.7070305@firmworks.com>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
	<fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
	<4B8A2CD7.7070305@firmworks.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 28 Feb 2010 07:47:32 -0700
Message-ID: <fa686aa41002280647q55e7940ej137ba3df052313c5@mail.gmail.com>
Subject: Re: [PATCH 1/3] video: add support for getting video mode from device
	tree
To: Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 28, 2010 at 1:44 AM, Mitch Bradley <wmb@firmworks.com> wrote:
> Grant Likely Wrote:
>> On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrot=
e:
>> Also, since you're now in the realm of describing a video display,
>> which is separate from the display controller, you should consider
>> describing the display in a separate device tree node. =A0Maybe
>> something like this...
>>
>> video {
>> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5121-diu";
>> =A0 =A0 =A0 =A0display {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "<vendor>,<model>";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edid =3D [edid-data];
>> =A0 =A0 =A0 =A0};
>> };
>>
>
>
> As it turns out, I'm doing exactly that - exporting verbatim EDID data as
> the value of the "edid" property - for the display node on the Via versio=
n
> of the OLPC machine. =A0The kernel driver uses it instead of trying to ob=
tain
> the EDID data from the monitor, because the builtin OLPC display cannot
> supply EDID data through the usual hardware interfaces.

Cool.  That sounds sane then.  How do you go about generating the EDID
data?  Is there a tool that can do that?  Or did you hand craft it?

Cheers,
g.
