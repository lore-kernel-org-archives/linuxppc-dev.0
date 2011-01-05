Return-Path: <meador_inge@mentor.com>
Message-ID: <4D24EEC0.2020909@mentor.com>
Date: Wed, 05 Jan 2011 16:20:48 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
References: <4D12F171.7010103@mentor.com>
	<20101223185623.GA20384@angua.secretlab.ca>
	<4D13C402.2090209@mentor.com>
	<20101223223325.GK20384@angua.secretlab.ca>
In-Reply-To: <20101223223325.GK20384@angua.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/23/2010 04:33 PM, Grant Likely wrote:
> This argument has been rehashed many times, but it basically comes
> down to compatible values should ideally be anchored to a real
> implemented device, not to a family of devices, or to an unversioned
> specification.
>
> In practise, the implementation doesn't actually look any different
> except that the 'reference' version specifies a specific
> implementation instead of a generic name.  To use a concrete example,
> if there are two parts using this MPIC, like the freescale p2040 and
> p4080, and say for argument that the p2040 was implemented first, then
> the compatible values would look like:
>
> for the p2040:   compatible = "fsl,p2040-msgr";
> for the p4080:   compatible = "fsl,p4080-msgr", "fsl,p2040-msgr";
>
> and the driver could simply bind on "fsl,p2040-msgr" to work with both
> chips.  So, instead of an arbitrary "fsl,mpic-msgr" string,
> "fsl,p2040-msgr" is used as the baseline value and there is no
> ambiguity about which part it describes.
>
> If the p4080 is actually subtly different from the p2040, then
> it would not claim compatibility with the former and the driver can
> match against either string; adapting its behaviour as necessary.

Thanks for the explanation.  I see now that there is a warning note in 
'http://www.devicetree.org/Device_Tree_Usage' about this case.  Perhaps 
a "best practices" guide for writing bindings might be useful as well. 
I would be happy to contribute to that, but I am still learning the best 
practices :)

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
