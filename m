Return-Path: <michael@ellerman.id.au>
Message-ID: <1343173422.2218.2.camel@concordia>
Subject: Re: [2/3][PATCH][upstream] TDM Framework
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
Date: Wed, 25 Jul 2012 09:43:42 +1000
In-Reply-To: <500EB47F.1040903@freescale.com>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
 <500EB47F.1040903@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-24 at 09:43 -0500, Timur Tabi wrote:
> Singh Sandeep-B37400 wrote:
> 
> >> +int tdm_adap_send(struct tdm_adapter *adap, void **buf, int count) {
> >> +       int res;
> >> +
> >> +       if (adap->algo->tdm_write)
> >> +               res = adap->algo->tdm_write(adap, buf, count);
> > 
> > Why does tdm_write() return a u32?  And shouldn't 'res' also be a u32, to make tdm_write()?
> > [Sandeep] tdm_write() returns number of bytes written. You are right, 'res' should be declared as u32
> 
> Then it should return an unsigned int.  You should used a sized integer
> type only when the size really matters (e.g. hardware registers or packed
> fields in a structure).
> 
> >> +/* tdm_adapter_mode is to define in mode of the device */ enum 
> >> +tdm_adapter_mode {
> >> +       TDM_ADAPTER_MODE_NONE = 0x00,
> >> +       TDM_ADAPTER_MODE_T1 = 0x01,
> >> +       TDM_ADAPTER_MODE_E1 = 0x02,
> >> +       TDM_ADAPTER_MODE_T1_RAW = 0x10,
> >> +       TDM_ADAPTER_MODE_E1_RAW = 0x20,
> > 
> > Where did these numbers come from?
> > [Sandeep] This is not related to any bit definition, just enum values.
> 
> Yes, but why these particular numbers?  Also, do they really need to be an
> enum?  Since you're defining hard values for each enum, you're not really
> using them as an enum.  Make these into macros.

I agree these values are odd. But there's no rule that you can only use
an enum if the values are monotonically increasing.

It can still serve as helpful documentation, and reduce the number of
places you pass a bare int around.

cheers
