Date: 25 Jun 2002 14:22:49 -0000
Message-ID: <20020625142249.2724.qmail@webmail15.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: some lead in scc2 conflict with usb?
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


SCC2 doesn't coflicts with USB ,I just have found the code in
enet.c that is causing problem for USB .


          cp->cp_sicr &= ~SICR_ENET_MASK;
          cp->cp_sicr |=  SICR_ENET_CLKRT;

if you are enabling USB before ENET then after initialising sicr
with SICR_ENET_MASK
USB is just able to recognise the RESET/IDLE events.

consequently when you put SICR_ENET_CLKRT USB becomes lifeless .

these are defined as ,

#ifdefined CONFIG_RPXLITE
#define SICR_ENET_MASK  ((uint)0x0000ff00)
#define SICR_ENET_CLKRT ((uint)0x00003d00)

In usb we are using the following for sicr initialisation
#define SICR_USB_MASK   ((uint)0x000000ff)
#define SICR_USB_CLKRT  ((uint)0x00000020) /* CLK1 */

how the ordering ( USB after ENET) matters here..?

Best Regards,

On Mon, 24 Jun 2002 Dan Malek wrote :
>
>navinb wrote:
>
>>problem being faced is that usb (scc1 addres space) works when
>>my
>>CPM ENET is not either at SCC1 or SCC2.
>
>How does USB conflict with SCC2 in Ethernet mode?  The default
>configuration should just build this way, since the only thing
>you can run on SCC1 is USB.  On an 823, the default (and about
>the only configuration) is USB on SCC1, Ethernet on SCC2 and
>console
>on SMC1.  Not all parts have SCC3.
>
>Thanks.
>
>
>-- Dan
>
>
>

_________________________________________________________
There is always a better job for you at Monsterindia.com.
Go now http://monsterindia.com/rediffin/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
