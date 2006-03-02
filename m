Return-Path: <jjboor@aimsys.nl>
Received: from mta-fe.casema.nl (cas-mta4-fe.casema.nl [83.80.1.32])
	by ozlabs.org (Postfix) with ESMTP id 9451E67A06
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 04:28:41 +1100 (EST)
In-Reply-To: <200603021706.14618.david.jander@protonic.nl>
References: <200603021706.14618.david.jander@protonic.nl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1A3EACD2-F5FF-472A-9DE0-7BBF04F68F5F@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: How to quickly write cleanmarkers to jffs2 partitions?
Date: Thu, 2 Mar 2006 18:07:37 +0100
To: David Jander <david.jander@protonic.nl>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

I indeed did write a small program that only writes the cleanmarkers
in all flash blocks used for jffs2. We assume (and check) all flash  
sectors
are erased already.

Jaap-Jan

On 2-mrt-2006, at 17:06, David Jander wrote:

>
> Hi,
>
> I was wondering if there is a trick or common technique I am  
> ignoring to make
> this more efficient:
>
> This is for a 2.4 kernel based system.
> In production we use either u-boot or a NFS mounted linux system to  
> erase
> flash and write jffs2 partitions to it. The jffs2 images are small  
> (not
> padded to full partition size to save programming time), but the  
> partitions
> are rather big (12 Mbyte in one case). Problem is that when booting  
> for the
> first time, one has to wait several minutes (during which the  
> system is more
> or less useless and busy) to get all cleanmarkers written to flash  
> by the
> jffs2 gc thread. This huge delay is rather unacceptable for  
> production, so we
> are looking for a work-around.
>
> One option would be to make jffs2 images that are padded to full  
> partition
> size, but that also isn't very efficient, considering the image is  
> only about
> 100k in beginning and the partition is 12 Mbyte in size. That would  
> take a
> lot of time programming flash (less time than having the jffs2  
> driver fix
> this nevertheless).
>
> Another option is making a little program that writes cleanmarkers  
> in every
> eraseblock starting from the first completely empty one in a  
> partition before
> mounting that partition for the very first time after flashing.
>
> Since this seems to me like a common situation, I'd like to know if  
> anybody
> knows about a better solution, or if anybody has already dealt with  
> this
> before.
>
> Greetings,
>
> -- 
> David Jander
> Protonic Holland.
> tel.: +31 (0) 229 212928
> fax.: +31 (0) 229 210930
> Factorij 36 / 1689 AL Zwaag
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> -- 
> This message has been scanned for viruses and is believed to be clean
>

____
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   jjboor at aimsys dot nl
