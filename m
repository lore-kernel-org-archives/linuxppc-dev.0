Date: Mon, 30 Jun 2003 09:00:51 +0200 (CEST)
From: Samuel Ortiz <samuel.ortiz@smartdata.ch>
Reply-To: samuel.ortiz@smartdata.ch
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Driver on Linux
In-Reply-To: <D96E2AFA0DF3D211B139009027454948034CBE5D@helios.gnv.tcc.thomson-csf.com>
Message-ID: <Pine.LNX.4.44.0306300853400.911-100000@jourdain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 27 Jun 2003 Christophe.LINDHEIMER@fr.thalesgroup.com wrote:

>
> Hi.
>
> I am working on a PPC860.
>
> I have developped two drivers.
>
> The driver 2 needs to use functions that are in driver 1.
> driver 1 is /dev/visu.
>
> I thought I could make fd=open("/dev/visu", 0) in init of the driver 2 but I
> get ooops.

Kernel file opening is usually considered a very bad idea. If driver 2
needs some of driver 1 functions, then you should consider exporting these
functions from driver 1 (EXPORT(driver1_function);).
Once driver1 is loaded, and thus initialized, any other driver will be
able to call driver 1 exported functions.

Hope this helps,
Samuel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
