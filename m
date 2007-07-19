Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <469FC275.7050309@smiths-aerospace.com>
Date: Thu, 19 Jul 2007 15:58:45 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
References: <20070719183415.7458.42622.stgit@trillian>	<20070719183734.7458.83695.stgit@trillian>	<469FB47D.4030009@freescale.com>
	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
In-Reply-To: <fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 7/19/07, Scott Wood <scottwood@freescale.com> wrote:
>> Grant Likely wrote:
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> To boot from a cuImage requires the device tree to have a
>>> linux,stdout-path property in the chosen node.  This patch adds it
>>> to the .dts files.
>> This will break many current u-boots, as they blindly add a /chosen node
>> regardless of whether one already exists.
> 
> That really should be fixed then.  In the meantime; I'll resubmit the
> patch to add the chosen node; but with it commented out.
> 
> g.

We are working on fixing that with the "u-boot-fdt" subtree, but it is 
slow going and it will not magically fix already fielded boards. 
(Forget that Harry Potter crap magic, _that_ would be some useful magic!)

I think the "proper" solution is not to add the /chosen node in the dts 
but rather to generate a _correct_ one in u-boot.  Note that 
linux,stdout-path is something that _should_ be generated based on the 
u-boot configuration (currently it is hard #defined, IMHO it should be 
part of the u-boot environment).

Looks like it is at fdt_support.c line 152:
<http://www.denx.de/cgi-bin/gitweb.cgi?p=u-boot/u-boot-fdt.git;a=blob;f=common/fdt_support.c;h=259bd42cc62c55d11370579a7af0d6519fc34c8d;hb=fdt#l152>

Best regards,
gvb
