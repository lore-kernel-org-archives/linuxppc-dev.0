Subject: Re: MPC860SAR MPHY try!!!
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: li <slowforce@21cn.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <JF969576804845.17327@webmail5.inner-21cn.com>
References: <JF969576804845.17327@webmail5.inner-21cn.com>
Content-Type: text/plain
Date: 23 Apr 2003 13:05:45 +0100
Message-Id: <1051099545.1757.279.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-04-23 at 12:51, li wrote:
> Hi ajz,
> I have implemented the native ATM communication with MPC860SAR and ppclinux(kernel 2.4.4), Now i want to try multiple PHY support on MPC860SAR.
>
> I have two PHYs, PHYA only for transmit and PHYB only for receive.

Err, MPHY means two BI-DIRECTIONAL PHYs!  Why have different PHYs for rx
and tx?


> Followed the MPC8xx_ATM doc, "each PHY in multi-phy mode has a
dedicated APC", that is i should allocate 2 APC parameter table for 2
PHYs and 2 APC table for 2 PHYs, is it right?
>

Sounds right.  You will really have to read the MPC862UM quite closely
to implement MPHY since the APC layout is quite different.

> Another question:
> Is there any problem with dev_data->ectbase, i think it should be
> &(dev_data->ectbase[NUM_INT_CONN_TABLES]);
> but your version is
> &(dev_data->ectbase[-NUM_INT_CONN_TABLES]);
>

No, there's no problem.  Read the MPC862UM. the ectbase pointer takes
into account the fact that the channel numbers start at 32.

> Regards!
> Li
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
