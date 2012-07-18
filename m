Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH] of: require a match on all fields of of_device_id
Date: Wed, 18 Jul 2012 01:57:53 +0000
Message-ID: <CAOZdJXVA-LAAok_weip8deTq4KER57yYAOsvY-Fm6czRYZuwzA@mail.gmail.com>
References: <20120718011151.GA6119@tyr.buserror.net>
In-Reply-To: <20120718011151.GA6119@tyr.buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2012 at 8:11 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> Commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6 ("of: match by compatible
> property first") breaks the gianfar ethernet driver found on various
> Freescale PPC chips.
>
> There are, for unfortunate historical reasons, two nodes with a
> compatible of "gianfar".

Would it be worth updating the binding for the two nodes to make the
compatible property different?  We could do something like this:

ethernet@24000 {
                        reg =3D <0x24000 0x1000>;
                        compatible =3D "fsl,gianfar-eth", "gianfar";
                        ...
};

(and something similar for MDIO nodes)

and update all the drivers to look for both strings.  After a few
years, we can delete "gianfar".

--=20
Timur Tabi
Linux kernel developer at Freescale=
