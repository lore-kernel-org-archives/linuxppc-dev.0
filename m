Date: Sun, 1 Jul 2001 01:11:46 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: problem in kernel-2.4.6.pre6
Message-ID: <20010701011146.O14317@corellia.laforge.distro.conectiva>
References: <20010630092151.Postino-012521@smtp01.highway.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <20010630092151.Postino-012521@smtp01.highway.ne.jp>; from k_fukui@highway.ne.jp on Sat, Jun 30, 2001 at 09:21:51AM +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 30, 2001 at 09:21:51AM +0900, Kaoru Fukui wrote:
>
> Hi!
>
> I have had compilation problem in kernel-2.4.6.pre6-devel also standard.
> The error is
>
> usb-ohci.c: Infunction 'ohci_sleep_notify'
> usb-ohci.c:2752 too few argments to function 'ohci_pci_supend'
>
>
> ochi_pci_suspend (strct pci_dev *dev, u32 state){
> <snip>
> }
>
> static int ohci_sleep_notify(struct pmu_sleep_notifier * self, int when){
> <snip>
>                   case PBOOK_SLEEP_NOW:
>                        ohci_pci_suspend(ohci->ohci_dev); <--- it's worng
> <snip>
>
> }

please see the attached "fix". As the u32 state argument is nowhere used in
ohci_pci_suspend, I think it's save to remove it.


> Kaoru

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linuxppc-300601-usb.patch"

--- linuxppc-300601/drivers/usb/usb-ohci.c.old	Sun Jul  1 05:04:38 2001
+++ linuxppc-300601/drivers/usb/usb-ohci.c	Sun Jul  1 05:04:48 2001
@@ -2586,7 +2586,7 @@
 /*-------------------------------------------------------------------------*/

 static int
-ohci_pci_suspend (struct pci_dev *dev, u32 state)
+ohci_pci_suspend (struct pci_dev *dev)
 {
 	ohci_t		*ohci = (ohci_t *) dev->driver_data;


--MGYHOYXEY6WxJCY8--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
