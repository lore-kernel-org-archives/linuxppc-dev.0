Return-Path: <meador_inge@mentor.com>
Message-ID: <4D377CE3.6000608@mentor.com>
Date: Wed, 19 Jan 2011 18:08:03 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: document the MPIC device tree binding
References: <4D34E448.8000902@mentor.com>
	<AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150306BF11@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150306BF11@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2011 04:14 PM, Yoder Stuart-B08248 wrote:
>
>> +** Optional properties:
>> +
>> +   - no-reset : The presence of this property indicates that the MPIC
>> +                should not be reset during runtime initialization.
>> +   - protected-sources : Specifies a list of interrupt sources that are
>> + not
>> +                         available for use and whose corresponding
>> + vectors
>> +                         should not be initialized.  A typical use case
>> + for
>> +                         this property is in AMP systems where multiple
>> +                         independent operating systems need to share
>> + the MPIC
>> +                         without clobbering each other.
>
> Is "protected-sources" really needed for AMP systems to
> tell the OSes not to clobber each other?  Won't each
> OS be given a device tree with only its interrupt
> sources?  ...so you know what you are allowed to touch.

This was discussed a little bit already [1, 2].  The MPIC driver 
currently initializes the VECPRI register for all interrupt sources, 
which can lead to the aforementioned clobbering.


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software

[1] 
http://lists.ozlabs.org/pipermail/devicetree-discuss/2010-December/003850.html
[2] 
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-January/003936.html
