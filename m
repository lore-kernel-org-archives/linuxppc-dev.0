Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: lmb_remove_region - bad decrementing...
Date: Mon, 19 Mar 2007 13:00:36 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D746E786@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This is based on 2.6.19 kernel.

In the file mm/lmb.c, we have function lmb_remove_region. In this
function we are decrementing the region count even if the condition
fails and we don't necessarily remove the region.

For example ...

static void __init lmb_remove_region(struct lmb_region *rgn, unsigned
long r)
{
        unsigned long i;

        for (i =3D r; i < rgn->cnt - 1; i++) {
                rgn->region[i].base =3D rgn->region[i + 1].base;
                rgn->region[i].size =3D rgn->region[i + 1].size;
        }
        rgn->cnt--;
}

Shound't the region count be decremented only if r > rgn->cnt -1. When
we initially setup lmb, cnt will be 1, and as part of other functions,
this gets called with out even increasing this number. So, region does
not get removed, but cnt does get decremented by 1.

At least a quick fix like this "if (rgn->cnt > 1) rgn->cnt--;" should
serve for now.

Same thing happens at routine lmb_enfore_memory_limit. Actually
lmb_remove_region gets called from here and the problem starts. So, "i"
should not be decremented here, if the initial condition fails.

What do you guys think?

Thanks
Siva
